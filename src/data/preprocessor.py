"""Data preprocessing pipeline for the career guidance system."""

import pandas as pd
import numpy as np
from typing import Dict, List
from pathlib import Path
import joblib
from sklearn.preprocessing import LabelEncoder

class DataPreprocessor:
    """Preprocess student data for model training."""
    
    def __init__(self):
        """Initialize preprocessor with necessary encoders."""
        self.stream_encoder = LabelEncoder()
        self.field_encoder = LabelEncoder()
        # Remove grade encoding since we'll keep grades as strings
    
    def _process_grades(self, grades: Dict[str, str]) -> Dict[str, str]:
        """Process grades while maintaining letter grade format."""
        return {
            subject: grade.upper()  # Just ensure consistent uppercase format
            for subject, grade in grades.items()
            if grade in ['A', 'B', 'C', 'S', 'F']
        }
    
    def preprocess_single(self, data: Dict) -> Dict:
        """Preprocess a single student profile."""
        processed = {}
        
        # Process O/L results
        if 'ol_results' in data:
            ol_grades = self._process_grades(data['ol_results'])
            processed.update({f'ol_{k}': v for k, v in ol_grades.items()})
        
        # Process A/L results
        if 'al_results' in data:
            al_data = data['al_results']
            processed['al_stream'] = al_data['stream']
            al_grades = self._process_grades(al_data['subjects'])
            processed.update({f'al_{k}': v for k, v in al_grades.items()})
        
        # Process university data
        if 'university_data' in data:
            uni_data = data['university_data']
            processed.update({
                'university_field': uni_data['field_of_study'],
                'university_year': uni_data['current_year'],
                'university_gpa': uni_data['current_gpa']
            })
        
        return processed
    
    def fit(self, data: List[Dict]):
        """Fit preprocessor on training data."""
        # Extract all streams and fields for encoding
        streams = set()
        fields = set()
        
        for profile in data:
            if 'al_results' in profile:
                streams.add(profile['al_results']['stream'])
            if 'university_data' in profile:
                fields.add(profile['university_data']['field_of_study'])
        
        # Fit encoders
        self.stream_encoder.fit(list(streams))
        self.field_encoder.fit(list(fields))
    
    def transform(self, data: List[Dict]) -> pd.DataFrame:
        """Transform data using fitted preprocessor."""
        processed_data = []
        for profile in data:
            processed = self.preprocess_single(profile)
            processed_data.append(processed)
        
        df = pd.DataFrame(processed_data)
        
        # Encode categorical columns
        if 'al_stream' in df.columns:
            df['al_stream'] = self.stream_encoder.transform(df['al_stream'])
        if 'university_field' in df.columns:
            df['university_field'] = self.field_encoder.transform(df['university_field'])
        
        return df
    
    def fit_transform(self, data: List[Dict]) -> pd.DataFrame:
        """Fit preprocessor and transform data."""
        self.fit(data)
        return self.transform(data)
    
    def save(self, path: str):
        """Save fitted preprocessor to disk."""
        joblib.dump(self, path)
    
    @classmethod
    def load(cls, path: str) -> 'DataPreprocessor':
        """Load fitted preprocessor from disk."""
        return joblib.load(path)
