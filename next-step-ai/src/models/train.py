"""Train LightGBM models for career guidance."""

import lightgbm as lgb
import numpy as np
import pandas as pd
from typing import Dict, List, Any, Tuple
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, precision_recall_fscore_support, confusion_matrix
from sklearn.preprocessing import LabelEncoder
import onnxmltools
from pathlib import Path
from onnx import TensorProto
from onnxmltools.convert.common.data_types import FloatTensorType

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
        
    def prepare_stream_recommender_data(self, df):
        """Prepare data for stream recommender model."""
        # Select students with stream information
        mask = df['stream'].notna()
        if not mask.any():
            raise ValueError("No students with A/L results found in the dataset")
        
        # Select features and target
        feature_cols = ['mathematics', 'science', 'english', 'sinhala', 'religion', 'history']
        X = df[mask][feature_cols]
        y = df[mask]['stream']
        
        # Convert grades to numeric values
        grade_map = {
            'A': 4,
            'B': 3,
            'C': 2,
            'S': 1,
            'F': 0
        }
        X = X.replace(grade_map)
        
        # Encode stream labels
        self.stream_encoder = LabelEncoder()
        y = self.stream_encoder.fit_transform(y)
        
        print("\nFeature Statistics:")
        print(f"Number of features: {len(feature_cols)}")
        print("\nFeature columns:", feature_cols)
        print("\nNumber of samples:", len(X))
        print("\nStream distribution:")
        stream_dist = pd.Series(y).value_counts()
        for label, count in stream_dist.items():
            stream_name = self.stream_encoder.inverse_transform([label])[0]
            percentage = (count/len(y)) * 100
            print(f"{stream_name}: {count} samples ({percentage:.1f}%)")
        
        return X, y

    def prepare_university_recommender_data(self, df):
        """Prepare data for university field recommender model."""
        # Select students with university field information
        mask = df['university_field'].notna()
        if not mask.any():
            raise ValueError("No students with university field information found in the dataset")
        
        # Get all A/L subject columns (those ending with '_grade')
        al_subject_cols = [col for col in df.columns if col.endswith('_grade')]
        
        # Combine O/L and A/L features
        feature_cols = ['mathematics', 'science', 'english', 'sinhala', 'religion', 'history', 'stream'] + al_subject_cols
        
        X = df[mask][feature_cols]
        y = df[mask]['university_field']
        
        # Convert grades to numeric values
        grade_map = {
            'A': 4,
            'B': 3,
            'C': 2,
            'S': 1,
            'F': 0
        }
        
        # Convert all grade columns
        for col in X.columns:
            if col != 'stream':  # Don't convert the stream column
                X[col] = X[col].replace(grade_map)
        
        # Encode categorical variables
        self.stream_encoder = LabelEncoder()
        X['stream'] = self.stream_encoder.fit_transform(X['stream'])
        
        self.field_encoder = LabelEncoder()
        y = self.field_encoder.fit_transform(y)
        
        print("\nFeature Statistics:")
        print(f"Number of features: {len(feature_cols)}")
        print("\nFeature columns:", feature_cols)
        print("\nNumber of samples:", len(X))
        print("\nUniversity field distribution:")
        field_dist = pd.Series(y).value_counts()
        for label, count in field_dist.items():
            field_name = self.field_encoder.inverse_transform([label])[0]
            percentage = (count/len(y)) * 100
            print(f"{field_name}: {count} samples ({percentage:.1f}%)")
        
        return X, y
    
    def generate_training_data(self, size: int = 10000) -> list:
        """Generate and preprocess training data."""
        # Generate synthetic data
        raw_data = self.generator.generate_dataset(size)
        
        # Preprocess data
        return raw_data
    
    def train_model(self, X_train, X_test, y_train, y_test, params, feature_names, model_type="stream"):
        print(f"\n=== Training {model_type.title()} Recommender ===")
        print("\nTraining Data Statistics:")
        print(f"Training samples: {X_train.shape[0]}")
        print(f"Testing samples: {X_test.shape[0]}")
        print(f"Number of features: {X_train.shape[1]}")
        
        # Class distribution
        print("\nClass Distribution:")
        train_dist = pd.Series(y_train).value_counts()
        for label, count in train_dist.items():
            percentage = (count/len(y_train)) * 100
            print(f"Class {label}: {count} samples ({percentage:.1f}%)")
        
        # Create dataset for lightgbm
        train_data = lgb.Dataset(X_train, label=y_train, feature_name=feature_names)
        test_data = lgb.Dataset(X_test, label=y_test, reference=train_data)
        
        print("\nTraining Progress:")
        model = lgb.train(
            params,
            train_data,
            valid_sets=[test_data],
            callbacks=[
                lgb.early_stopping(stopping_rounds=50),
                lgb.log_evaluation(period=100)
            ]
        )
        
        # Make predictions
        y_pred = model.predict(X_test)
        y_pred_labels = np.argmax(y_pred, axis=1)
        
        # Calculate metrics
        accuracy = accuracy_score(y_test, y_pred_labels)
        precision = precision_score(y_test, y_pred_labels, average='weighted', zero_division=0)
        recall = recall_score(y_test, y_pred_labels, average='weighted')
        f1 = f1_score(y_test, y_pred_labels, average='weighted')
        
        print(f"\n{model_type.title()} Recommender Metrics:")
        print(f"Accuracy: {accuracy:.4f}")
        print(f"Precision: {precision:.4f}")
        print(f"Recall: {recall:.4f}")
        print(f"F1 Score: {f1:.4f}")
        
        # Confusion Matrix
        print("\nConfusion Matrix:")
        cm = confusion_matrix(y_test, y_pred_labels)
        print(cm)
        
        # Feature Importance
        importance = model.feature_importance(importance_type='gain')
        feature_importance = pd.DataFrame({
            'feature': feature_names,
            'importance': importance
        }).sort_values('importance', ascending=False)
        
        print("\nTop Features by Importance:")
        for _, row in feature_importance.iterrows():
            print(f"{row['feature']}: {row['importance']:.0f}")
        
        # Sample Predictions
        print("\nSample Predictions (First 5):")
        for i in range(5):
            true_label = y_test[i]
            pred_label = y_pred_labels[i]
            confidence = np.max(y_pred[i])
            print(f"True: {true_label}, Predicted: {pred_label}, Confidence: {confidence:.2f}")
        
        return model, feature_importance

    def train_stream_recommender(self, df):
        """Train model to recommend A/L stream based on O/L results."""
        # Prepare data
        X, y = self.prepare_stream_recommender_data(df)
        
        # Create composite features
        X['science_math_avg'] = (X['mathematics'] + X['science']) / 2
        X['language_avg'] = (X['english'] + X['sinhala']) / 2
        
        # Split data
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=0.2, random_state=self.seed, stratify=y
        )
        
        # Train model
        params = {
            'objective': 'multiclass',
            'metric': 'multi_logloss',
            'num_class': len(np.unique(y)),
            'learning_rate': 0.01,  # Reduced for better convergence
            'num_leaves': 31,
            'min_data_in_leaf': 20,
            'max_depth': 8,
            'feature_fraction': 0.8,
            'bagging_fraction': 0.8,
            'bagging_freq': 5,
            'lambda_l1': 0.1,
            'lambda_l2': 0.1,
            'verbose': -1
        }
        
        model, _ = self.train_model(X_train, X_test, y_train, y_test, params, X.columns.tolist(), model_type="stream")
        
        return model

    def train_university_recommender(self, df):
        """Train model to recommend university field based on A/L results."""
        # Prepare features
        X, y = self.prepare_university_recommender_data(df)
        
        # Create composite features for science subjects
        science_subjects = ['physics_grade', 'chemistry_grade', 'biology_grade']
        math_subjects = ['combined_maths_grade', 'engineering_technology_grade']
        commerce_subjects = ['economics_grade', 'business_studies_grade', 'accounting_grade']
        
        # Add composite features where available
        if all(col in X.columns for col in science_subjects):
            X['science_avg'] = X[science_subjects].mean(axis=1)
        if all(col in X.columns for col in math_subjects):
            X['math_avg'] = X[math_subjects].mean(axis=1)
        if all(col in X.columns for col in commerce_subjects):
            X['commerce_avg'] = X[commerce_subjects].mean(axis=1)
        
        # Split data with stratification
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=0.2, random_state=self.seed, stratify=y
        )
        
        # Train model
        params = {
            'objective': 'multiclass',
            'metric': 'multi_logloss',
            'num_class': len(np.unique(y)),
            'learning_rate': 0.01,
            'num_leaves': 63,
            'min_data_in_leaf': 30,
            'max_depth': 10,
            'feature_fraction': 0.7,
            'bagging_fraction': 0.7,
            'bagging_freq': 5,
            'lambda_l1': 0.1,
            'lambda_l2': 0.1,
            'verbose': -1
        }
        
        model, _ = self.train_model(X_train, X_test, y_train, y_test, params, X.columns.tolist(), model_type="university")
        
        return model
    
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
    # Create output directory
    output_dir = Path('models/output')
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Initialize trainer
    trainer = ModelTrainer()
    
    # Generate and prepare data
    print("Generating training data...")
    df = trainer.generate_training_data(size=10000)
    
    # Train stream recommender
    print("\nTraining stream recommender...")
    stream_model = trainer.train_stream_recommender(df)
    
    # Train university field recommender
    print("\nTraining university field recommender...")
    uni_model = trainer.train_university_recommender(df)
    
    # Export models to ONNX
    print("\nExporting models to ONNX...")
    stream_X, _ = trainer.prepare_stream_recommender_data(df)
    trainer.export_model_to_onnx(
        stream_model,
        stream_X.columns.tolist(),
        output_dir / 'stream_recommender.onnx'
    )
    
    uni_X, _ = trainer.prepare_university_recommender_data(df)
    trainer.export_model_to_onnx(
        uni_model,
        uni_X.columns.tolist(),
        output_dir / 'university_recommender.onnx'
    )
    
    print("Training complete! Models exported to models/output/")

if __name__ == '__main__':
    main()
