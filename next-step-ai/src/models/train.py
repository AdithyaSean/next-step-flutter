"""Train LightGBM models for career guidance."""

import lightgbm as lgb
import numpy as np
import pandas as pd
from typing import Dict, List, Any, Tuple
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, precision_recall_fscore_support, confusion_matrix
from sklearn.preprocessing import LabelEncoder, StandardScaler
import onnxmltools
from pathlib import Path
from onnx import TensorProto
from onnxmltools.convert.common.data_types import FloatTensorType
from sklearn.utils.class_weight import compute_class_weight
from sklearn.model_selection import StratifiedKFold

from src.data.generators.dataset_generator import StudentDataGenerator
from src.data.preprocessor import DataPreprocessor

GRADE_TO_NUMERIC = {
    'A': 5,
    'B': 4,
    'C': 3,
    'S': 2,
    'F': 1
}

class ModelTrainer:
    """Train and evaluate LightGBM models."""
    
    def __init__(self, seed: int = 42):
        """Initialize trainer with random seed."""
        self.seed = seed
        self.preprocessor = DataPreprocessor()
        self.generator = StudentDataGenerator(seed=seed)
        self.stream_encoder = LabelEncoder()
        self.field_encoders = {}  # One encoder per stream
        
    def prepare_stream_recommender_data(self, df: pd.DataFrame) -> Tuple[pd.DataFrame, pd.Series]:
        """Prepare data for stream recommender model."""
        X = df[['mathematics', 'science', 'english', 'sinhala', 'religion', 'history']].copy()
        X = X.apply(lambda x: pd.to_numeric(x.map(GRADE_TO_NUMERIC), errors='coerce')).fillna(0).infer_objects(copy=False)
        
        # Add derived features
        X['science_math_avg'] = (X['mathematics'] + X['science']) / 2
        X['language_avg'] = (X['english'] + X['sinhala']) / 2
        X['science_math_product'] = X['mathematics'] * X['science']
        
        # Scale features
        scaler = StandardScaler()
        X_scaled = scaler.fit_transform(X)
        X = pd.DataFrame(X_scaled, columns=X.columns, index=X.index)
        
        # Encode stream labels
        y = self.stream_encoder.fit_transform(df['stream'])
        
        return X, y

    def prepare_university_recommender_data(self, df: pd.DataFrame) -> Tuple[pd.DataFrame, pd.Series, pd.Series]:
        """Prepare data for university field recommender model."""
        # Get all relevant columns
        al_grade_cols = [col for col in df.columns if col.endswith('_grade')]
        feature_cols = ['stream'] + al_grade_cols
        
        # Only use records with university data
        mask = df['university_field'].notna()
        df_filtered = df[mask].copy()
        
        X = df_filtered[feature_cols].copy()
        y_stream = df_filtered['stream']
        y_field = df_filtered['university_field']
        
        # Convert grades to numeric values
        grade_cols = [col for col in X.columns if col != 'stream']
        for col in grade_cols:
            X[col] = pd.to_numeric(X[col].map(GRADE_TO_NUMERIC), errors='coerce').fillna(-1)
        
        # Add grade-based features
        X['avg_grade'] = X[grade_cols].mean(axis=1)
        X['min_grade'] = X[grade_cols].min(axis=1)
        X['max_grade'] = X[grade_cols].max(axis=1)
        X['grade_std'] = X[grade_cols].std(axis=1)
        X['grade_range'] = X['max_grade'] - X['min_grade']
        X['top_2_avg'] = X[grade_cols].apply(lambda x: np.mean(sorted(x)[-2:]), axis=1)
        X['bottom_2_avg'] = X[grade_cols].apply(lambda x: np.mean(sorted(x)[:2]), axis=1)
        
        # Add count-based features
        for grade in range(1, 5):  # A, B, C, S grades
            X[f'grade_{grade}_count'] = X[grade_cols].apply(lambda x: np.sum(x == grade), axis=1)
        
        # Create stream-specific features
        stream_dummies = pd.get_dummies(X['stream'], prefix='stream')
        X = pd.concat([X.drop('stream', axis=1), stream_dummies], axis=1)
        
        # Add interaction features between grades and streams
        for stream_col in stream_dummies.columns:
            X[f'{stream_col}_avg_grade'] = X['avg_grade'] * X[stream_col]
            X[f'{stream_col}_top_2_avg'] = X['top_2_avg'] * X[stream_col]
            X[f'{stream_col}_grade_std'] = X['grade_std'] * X[stream_col]
        
        # Scale numerical features
        numerical_cols = X.select_dtypes(include=['int64', 'float64']).columns
        scaler = StandardScaler()
        X[numerical_cols] = scaler.fit_transform(X[numerical_cols])
        
        # Encode stream labels
        y_stream = self.stream_encoder.fit_transform(y_stream)
        
        # Store original field labels for later use
        self.original_fields = y_field
        
        return X, y_stream, y_field

    def generate_training_data(self, size: int = 10000) -> list:
        """Generate and preprocess training data."""
        # Generate synthetic data
        raw_data = self.generator.generate_dataset(size)
        
        # Preprocess data
        return raw_data
    
    def train_model(self, X_train, X_test, y_train, y_test, params, feature_names, model_type="stream"):
        """Train and evaluate a LightGBM model."""
        train_data = lgb.Dataset(X_train, label=y_train, feature_name=feature_names)
        test_data = lgb.Dataset(X_test, label=y_test, reference=train_data)
        
        # Update params to use gbdt instead of dart
        params.update({
            'boosting_type': 'gbdt',  # Changed from dart to enable early stopping
            'objective': 'multiclass',
            'metric': 'multi_logloss',
            'num_class': len(np.unique(y_train)),
            'feature_fraction': 0.8,
            'bagging_fraction': 0.8,
            'bagging_freq': 5,
            'learning_rate': 0.05,
            'num_leaves': 31,
            'verbose': -1,
            'seed': self.seed
        })
        
        # Train model with minimal output
        model = lgb.train(
            params,
            train_data,
            valid_sets=[test_data],
            callbacks=[lgb.early_stopping(stopping_rounds=50)]
        )
        
        # Make predictions
        y_pred = model.predict(X_test)
        y_pred_labels = np.argmax(y_pred, axis=1)
        
        # Calculate and log key metrics
        metrics = {
            'accuracy': accuracy_score(y_test, y_pred_labels),
            'precision': precision_score(y_test, y_pred_labels, average='weighted', zero_division=0),
            'recall': recall_score(y_test, y_pred_labels, average='weighted'),
            'f1': f1_score(y_test, y_pred_labels, average='weighted')
        }
        
        print(f"\n{model_type.title()} Model Metrics:")
        for metric, value in metrics.items():
            print(f"{metric.title()}: {value:.4f}")
        
        # Calculate feature importance
        importance = model.feature_importance(importance_type='gain')
        feature_importance = pd.DataFrame({
            'feature': feature_names,
            'importance': importance
        }).sort_values('importance', ascending=False)
        
        return model, feature_importance

    def train_stream_recommender(self, df):
        """Train model to recommend A/L stream based on O/L results."""
        X, y = self.prepare_stream_recommender_data(df)
        
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=0.2, random_state=self.seed, stratify=y
        )
        
        params = {
            'learning_rate': 0.01,
            'num_leaves': 63,
            'max_depth': 8,
            'min_data_in_leaf': 30,
            'lambda_l1': 0.1,
            'lambda_l2': 0.1,
            'is_unbalance': True,
            'drop_rate': 0.1,
            'max_drop': 50,
        }
        
        model, feature_importance = self.train_model(
            X_train, X_test, y_train, y_test, 
            params, X.columns.tolist(), 
            model_type="stream"
        )
        
        return model

    def train_university_recommender(self, df):
        """Train model to recommend university field based on A/L results using hierarchical approach."""
        X, y_stream, y_field = self.prepare_university_recommender_data(df)
        
        # Train stream-specific models
        stream_models = {}
        
        for stream_idx, stream in enumerate(self.stream_encoder.classes_):
            print(f"\nTraining model for {stream} stream:")
            
            # Get data for this stream
            stream_mask = y_stream == stream_idx
            X_stream = X[stream_mask]
            stream_fields = y_field[stream_mask]
            
            if len(X_stream) < 10:  # Skip if too few samples
                print(f"Insufficient data for {stream} stream")
                continue
            
            # Create and fit a new encoder for this stream's fields
            stream_encoder = LabelEncoder()
            y_stream_fields = stream_encoder.fit_transform(stream_fields)
            self.field_encoders[stream] = stream_encoder
            
            print(f"Number of unique fields for {stream}: {len(stream_encoder.classes_)}")
            print("Fields:", stream_encoder.classes_)
            
            # Use stratified k-fold for this stream
            n_splits = min(5, len(np.unique(y_stream_fields)))
            skf = StratifiedKFold(n_splits=n_splits, shuffle=True, random_state=self.seed)
            
            # Initialize metrics storage for this stream
            cv_metrics = {
                'accuracy': [], 'precision': [], 'recall': [], 'f1': []
            }
            
            for fold, (train_idx, val_idx) in enumerate(skf.split(X_stream, y_stream_fields), 1):
                X_train, X_val = X_stream.iloc[train_idx], X_stream.iloc[val_idx]
                y_train, y_val = y_stream_fields[train_idx], y_stream_fields[val_idx]
                
                # Calculate class weights for this fold
                class_weights = compute_class_weight('balanced', classes=np.unique(y_train), y=y_train)
                class_weight_str = ','.join([f'{i}={w}' for i, w in enumerate(class_weights)])
                
                params = {
                    'objective': 'multiclass',
                    'metric': 'multi_logloss',
                    'num_class': len(stream_encoder.classes_),
                    'learning_rate': 0.005,  # Reduced from 0.01
                    'num_leaves': 63,  # Increased from 31
                    'max_depth': 8,  # Increased from 6
                    'min_data_in_leaf': 5,  # Reduced from 10
                    'feature_fraction': 0.9,  # Increased from 0.8
                    'bagging_fraction': 0.9,  # Increased from 0.8
                    'bagging_freq': 5,
                    'lambda_l1': 0.05,  # Reduced from 0.1
                    'lambda_l2': 0.05,  # Reduced from 0.1
                    'scale_pos_weight': class_weight_str,
                    'verbose': -1,
                    'seed': self.seed + fold,
                    'min_gain_to_split': 0.0,  # Allow more splits
                    'min_sum_hessian_in_leaf': 0.001,  # Allow smaller nodes
                    'boost_from_average': True,
                    'is_unbalance': True  # Handle imbalanced data
                }
                
                # Train model for this fold
                train_data = lgb.Dataset(X_train, label=y_train)
                val_data = lgb.Dataset(X_val, label=y_val, reference=train_data)
                
                model = lgb.train(
                    params,
                    train_data,
                    num_boost_round=1000,
                    valid_sets=[val_data],
                    callbacks=[lgb.early_stopping(stopping_rounds=50)]
                )
                
                # Make predictions
                y_pred = model.predict(X_val)
                y_pred_labels = np.argmax(y_pred, axis=1)
                
                # Calculate metrics for this fold
                fold_metrics = {
                    'accuracy': accuracy_score(y_val, y_pred_labels),
                    'precision': precision_score(y_val, y_pred_labels, average='weighted', zero_division=0),
                    'recall': recall_score(y_val, y_pred_labels, average='weighted'),
                    'f1': f1_score(y_val, y_pred_labels, average='weighted')
                }
                
                # Store metrics
                for metric, value in fold_metrics.items():
                    cv_metrics[metric].append(value)
                
                print(f"\nFold {fold} Metrics:")
                for metric, value in fold_metrics.items():
                    print(f"{metric.title()}: {value:.4f}")
            
            # Print average metrics for this stream
            print(f"\nAverage Metrics for {stream} stream:")
            for metric, values in cv_metrics.items():
                print(f"{metric.title()}: {np.mean(values):.4f} ± {np.std(values):.4f}")
            
            # Train final model for this stream on all data
            params['seed'] = self.seed
            train_data = lgb.Dataset(X_stream, label=y_stream_fields)
            stream_models[stream] = lgb.train(params, train_data, num_boost_round=1000)
        
        return stream_models

    def export_model_to_onnx(
        self,
        model: lgb.Booster,
        feature_names: list,
        output_path: Path,
        num_classes: int = None
    ) -> None:
        """Export LightGBM model to ONNX format."""
        if num_classes is None:
            num_classes = model.params.get('num_class', 1)
        
        # Create initial type for the features
        initial_type = [('input', FloatTensorType([None, len(feature_names)]))]
        
        # Convert to ONNX
        onnx_model = onnxmltools.convert_lightgbm(
            model,
            initial_types=initial_type,
            target_opset=13,
            name='NextStepAI'
        )
        
        # Save model
        onnxmltools.utils.save_model(onnx_model, output_path)

def main():
    """Train and export models."""
    output_dir = Path('models/output')
    output_dir.mkdir(parents=True, exist_ok=True)
    
    trainer = ModelTrainer()
    df = trainer.generate_training_data(size=10000)
    
    # Train and export stream recommender
    stream_model = trainer.train_stream_recommender(df)
    stream_X, _ = trainer.prepare_stream_recommender_data(df)
    trainer.export_model_to_onnx(
        stream_model,
        stream_X.columns.tolist(),
        output_dir / 'stream_recommender.onnx'
    )
    
    # Train and export university field recommender
    uni_models = trainer.train_university_recommender(df)
    for stream, model in uni_models.items():
        uni_X, _, _ = trainer.prepare_university_recommender_data(df)
        trainer.export_model_to_onnx(
            model,
            uni_X.columns.tolist(),
            output_dir / f'university_recommender_{stream}.onnx'
        )

if __name__ == '__main__':
    main()
