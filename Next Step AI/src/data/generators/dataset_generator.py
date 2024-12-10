"""Generate synthetic student data for training."""

import numpy as np
import random
from typing import Dict, List, Any
import uuid
from . import config

class StudentDataGenerator:
    """Generate synthetic student data."""
    
    def __init__(self, seed: int = None):
        """Initialize the generator with an optional seed."""
        if seed is not None:
            np.random.seed(seed)
            random.seed(seed)
    
    def _generate_grade(self) -> str:
        """Generate a random grade."""
        return np.random.choice(config.GRADES)
    
    def generate_ol_results(self) -> Dict[str, str]:
        """Generate O/L examination results."""
        return {subject: self._generate_grade() for subject in config.OL_SUBJECTS}
    
    def _select_weighted_item(self, items: List[str], weights: Dict[str, float]) -> str:
        """Select an item based on weights."""
        items_list = list(weights.keys())
        weights_list = [weights[item] for item in items_list]
        return np.random.choice(items_list, p=weights_list)
    
    def _generate_arts_subjects(self) -> Dict[str, str]:
        """Generate subjects for Arts stream."""
        subjects = {}
        stream_config = config.AL_STREAMS['ARTS']['groups']
        
        # Select one subject from each group based on weights
        for group, group_config in stream_config.items():
            subject = self._select_weighted_item(
                group_config['subjects'],
                group_config['weights']
            )
            subjects[subject] = self._generate_grade()
        
        return subjects
    
    def _generate_stream_subjects(self, stream: str) -> Dict[str, str]:
        """Generate subjects for non-Arts streams."""
        subjects = {}
        stream_config = config.AL_STREAMS[stream]
        
        # Add compulsory subjects
        for subject in stream_config['compulsory']:
            subjects[subject] = self._generate_grade()
        
        # Add one optional subject based on weights
        optional_subject = self._select_weighted_item(
            stream_config['optional'],
            stream_config['weights']
        )
        subjects[optional_subject] = self._generate_grade()
        
        return subjects
    
    def generate_al_results(self) -> Dict[str, Any]:
        """Generate A/L examination results."""
        # Select stream based on weights
        stream = self._select_weighted_item(
            list(config.STREAM_WEIGHTS.keys()),
            config.STREAM_WEIGHTS
        )
        
        # Generate subjects based on stream
        if stream == 'ARTS':
            subjects = self._generate_arts_subjects()
        else:
            subjects = self._generate_stream_subjects(stream)
        
        return {
            'stream': stream,
            'subjects': subjects
        }
    
    def generate_university_data(self, stream: str) -> Dict[str, Any]:
        """Generate university-related data."""
        stream_config = config.UNIVERSITY_FIELDS[stream]
        
        # Select field based on weights
        field = self._select_weighted_item(
            stream_config['fields'],
            stream_config['weights']
        )
        
        return {
            'field_of_study': field,
            'current_year': random.randint(1, 4),
            'current_gpa': round(random.uniform(2.0, 4.0), 2)
        }
    
    def generate_student(self) -> Dict[str, Any]:
        """Generate a complete student profile."""
        # Generate unique student ID
        student_id = f"ST{uuid.uuid4().hex[:8].upper()}"
        
        # Generate examination results
        ol_results = self.generate_ol_results()
        al_results = self.generate_al_results()
        
        # Generate university data based on A/L stream
        university_data = self.generate_university_data(al_results['stream'])
        
        return {
            'student_id': student_id,
            'ol_results': ol_results,
            'al_results': al_results,
            'university_data': university_data
        }
    
    def generate_dataset(self, size: int) -> List[Dict[str, Any]]:
        """Generate a dataset of student profiles."""
        return [self.generate_student() for _ in range(size)]
