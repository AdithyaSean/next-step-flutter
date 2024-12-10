"""Generate synthetic student data for training."""

import numpy as np
import random
from typing import Dict, List, Any
import uuid
from . import config
from tqdm import tqdm
import pandas as pd
from collections import defaultdict

class StudentDataGenerator:
    """Generate synthetic student data."""
    
    def __init__(self, seed: int = None):
        """Initialize the generator with an optional seed."""
        if seed is not None:
            np.random.seed(seed)
            random.seed(seed)
    
    def _generate_grade(self) -> str:
        """Generate a random grade based on configured probabilities."""
        return np.random.choice(
            config.GRADES,
            p=[config.GRADE_PROBABILITIES[grade] for grade in config.GRADES]
        )
    
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
    
    def _select_stream_based_on_grades(self, ol_results: Dict[str, str]) -> str:
        """Select A/L stream based on O/L results with sophisticated weighting."""
        # Convert grades to numeric values with more granular scoring
        grade_values = {'A': 5.0, 'B': 4.0, 'C': 3.0, 'S': 2.0, 'F': 1.0}
        numeric_grades = {subject: grade_values[grade] for subject, grade in ol_results.items()}
        
        # Calculate weighted subject averages
        science_math_avg = (numeric_grades['mathematics'] * 1.2 + numeric_grades['science'] * 1.0) / 2.2
        language_avg = (numeric_grades['english'] * 1.1 + numeric_grades['sinhala'] * 1.0) / 2.1
        
        # Calculate stream scores with subject interactions
        stream_scores = {
            'PHYSICAL_SCIENCE': (
                science_math_avg * 2.5 +  # Higher weight for math/science
                numeric_grades['science'] * 1.5 +
                max(0, (numeric_grades['mathematics'] - 3)) * 0.8  # Bonus for high math scores
            ),
            'BIOLOGICAL_SCIENCE': (
                science_math_avg * 1.5 +
                numeric_grades['science'] * 2.0 +  # Higher weight for science
                max(0, (numeric_grades['science'] - 3)) * 0.8  # Bonus for high science scores
            ),
            'TECHNOLOGY': (
                science_math_avg * 2.0 +
                numeric_grades['science'] * 1.2 +
                numeric_grades['mathematics'] * 1.3 +
                max(0, min(numeric_grades['science'], numeric_grades['mathematics']) - 3) * 0.5  # Bonus for balanced scores
            ),
            'COMMERCE': (
                numeric_grades['mathematics'] * 1.5 +
                language_avg * 1.2 +
                numeric_grades['english'] * 0.8 +  # Extra weight for English
                max(0, (numeric_grades['mathematics'] - 2)) * 0.5  # Smaller bonus for math
            ),
            'ARTS': (
                language_avg * 2.0 +
                numeric_grades['history'] * 1.5 +
                numeric_grades['religion'] * 0.8 +
                max(0, (language_avg - 3)) * 0.7  # Bonus for strong language skills
            )
        }
        
        # Add controlled randomness based on performance level
        base_performance = sum(numeric_grades.values()) / len(numeric_grades)
        randomness_scale = max(0.3, 1.0 - base_performance / 5.0)  # Less randomness for high performers
        
        for stream in stream_scores:
            stream_scores[stream] += np.random.normal(0, randomness_scale)
        
        # Select stream with highest score
        selected_stream = max(stream_scores.items(), key=lambda x: x[1])[0]
        
        # Apply stream distribution as a soft constraint with performance-based adjustment
        if np.random.random() > 0.7 + (base_performance / 10):  # Higher performers more likely to follow aptitude
            distribution_weights = list(config.STREAM_DISTRIBUTION.values())
            # Adjust weights based on performance
            if base_performance >= 4.0:  # High performers
                distribution_weights = [w * 1.2 if i < 3 else w * 0.8 for i, w in enumerate(distribution_weights)]
            selected_stream = np.random.choice(
                list(config.STREAM_DISTRIBUTION.keys()),
                p=[w/sum(distribution_weights) for w in distribution_weights]
            )
        
        return selected_stream

    def generate_al_results(self, ol_results: Dict[str, str]):
        """Generate A/L results based on O/L performance."""
        # Select stream based on O/L performance
        stream = self._select_stream_based_on_grades(ol_results)
        
        subjects = {}
        stream_config = config.AL_STREAMS[stream]
        
        # Convert O/L grades to numeric for correlation
        grade_values = {'A': 5, 'B': 4, 'C': 3, 'S': 2, 'F': 1}
        ol_numeric = {k: grade_values[v] for k, v in ol_results.items()}
        
        # Generate grades with correlation to relevant O/L subjects
        if stream == 'PHYSICAL_SCIENCE':
            base_score = (ol_numeric['mathematics'] + ol_numeric['science']) / 2
        elif stream == 'BIOLOGICAL_SCIENCE':
            base_score = (ol_numeric['science'] * 2 + ol_numeric['mathematics']) / 3
        elif stream == 'TECHNOLOGY':
            base_score = (ol_numeric['mathematics'] + ol_numeric['science']) / 2
        elif stream == 'COMMERCE':
            base_score = (ol_numeric['mathematics'] + ol_numeric['english']) / 2
        else:  # ARTS
            base_score = (ol_numeric['sinhala'] + ol_numeric['history']) / 2
        
        # Add compulsory subjects with correlation
        for subject in stream_config['compulsory']:
            # Add some randomness while maintaining correlation
            score = base_score + np.random.normal(0, 0.5)
            # Convert back to letter grade
            if score >= 4.5:
                grade = 'A'
            elif score >= 3.5:
                grade = 'B'
            elif score >= 2.5:
                grade = 'C'
            elif score >= 1.5:
                grade = 'S'
            else:
                grade = 'F'
            subjects[subject] = grade
        
        # Add optional subjects based on weights
        optional_subject = self._select_weighted_item(
            stream_config['optional'],
            stream_config['weights']
        )
        subjects[optional_subject] = self._generate_grade()
        
        return {
            'stream': stream,
            'subjects': subjects
        }
    
    def generate_university_data(self, stream: str) -> Dict[str, Any]:
        """Generate university data based on A/L stream."""
        fields = config.UNIVERSITY_FIELDS[stream]['fields']
        weights = config.UNIVERSITY_FIELDS[stream]['weights']
        
        # Select field based on weights
        field = np.random.choice(
            fields,
            p=[weights[f] for f in fields]
        )
        
        return {
            'field': field,
            'year': np.random.randint(1, 5)  # Current year of study
        }
    
    def generate_student(self):
        """Generate a single student's data."""
        # Generate O/L results first
        ol_results = self.generate_ol_results()
        
        # Generate A/L results based on O/L performance
        al_results = self.generate_al_results(ol_results)
        
        student_data = {
            'ol_results': ol_results,
            'al_results': al_results
        }
        
        # Add university field for some students
        if random.random() < 0.8:  # 80% chance of having university data
            student_data['university_data'] = self.generate_university_data(
                student_data['al_results']['stream']
            )
        
        return student_data
    
    def generate_dataset(self, size=6000):
        """Generate a synthetic dataset for training."""
        print("\n=== Data Generation Statistics ===")
        print(f"Generating {size} student records...")
        
        data = []
        stream_counts = {stream: 0 for stream in config.AL_STREAMS.keys()}
        field_counts = defaultdict(int)
        grade_distribution = defaultdict(lambda: defaultdict(int))
        
        for _ in tqdm(range(size)):
            student = self.generate_student()
            data.append(student)
            
            # Track statistics
            if 'al_results' in student:
                stream_counts[student['al_results']['stream']] += 1
            if 'university_data' in student:
                field_counts[student['university_data']['field']] += 1
            
            # Track grade distributions for key subjects
            if 'ol_results' in student:
                for subject in ['mathematics', 'science', 'english']:
                    if subject in student['ol_results']:
                        grade_distribution[subject][student['ol_results'][subject]] += 1
        
        # Convert nested dictionaries to flat structure for DataFrame
        flat_data = []
        for student in data:
            flat_student = {}
            
            # Add O/L results
            if 'ol_results' in student:
                for subject, grade in student['ol_results'].items():
                    flat_student[subject] = grade
            
            # Add A/L stream and subjects
            if 'al_results' in student:
                stream = student['al_results']['stream']
                flat_student['stream'] = stream
                
                # Add A/L subject grades
                if 'subjects' in student['al_results']:
                    for subject, grade in student['al_results']['subjects'].items():
                        flat_student[f"{subject}_grade"] = grade
            
            # Add university field
            if 'university_data' in student:
                flat_student['university_field'] = student['university_data']['field']
            
            flat_data.append(flat_student)
        
        df = pd.DataFrame(flat_data)
        
        # Print detailed statistics
        print("\n--- Stream Distribution ---")
        for stream, count in stream_counts.items():
            percentage = (count/size) * 100
            print(f"{stream}: {count} students ({percentage:.1f}%)")
        
        print("\n--- University Field Distribution ---")
        for field, count in field_counts.items():
            percentage = (count/size) * 100
            print(f"{field}: {count} students ({percentage:.1f}%)")
        
        print("\n--- Grade Distribution for Key Subjects ---")
        for subject, grades in grade_distribution.items():
            print(f"\n{subject.title()}:")
            total = sum(grades.values())
            for grade, count in sorted(grades.items()):
                percentage = (count/total) * 100
                print(f"Grade {grade}: {count} students ({percentage:.1f}%)")
        
        # Calculate and print correlations for key subjects
        key_subjects = ['mathematics', 'science', 'english', 'sinhala']
        key_subjects = [subj for subj in key_subjects if subj in df.columns]
        if key_subjects:
            print("\n--- Key Subject Correlations ---")
            grade_map = {
                'A': 4,
                'B': 3,
                'C': 2,
                'S': 1,
                'F': 0
            }
            numeric_df = df[key_subjects].replace(grade_map)
            corr_matrix = numeric_df.corr()
            print("\nCorrelation Matrix:")
            print(corr_matrix.round(3))
            
            # Print interpretation of correlations
            print("\nStrong Correlations (|r| > 0.5):")
            for i in range(len(key_subjects)):
                for j in range(i+1, len(key_subjects)):
                    corr = corr_matrix.iloc[i,j]
                    if abs(corr) > 0.5:
                        print(f"{key_subjects[i]} - {key_subjects[j]}: {corr:.3f}")
        
        print("\n--- Sample Records ---")
        print("\nFirst 5 student records:")
        print(df.head().to_string())
        
        return df
