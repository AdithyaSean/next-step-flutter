"""Generate synthetic student data for training."""

import numpy as np
import random
from typing import Dict, List, Any
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
    
    def _calculate_field_scores(self, stream: str, subjects: Dict[str, str]) -> Dict[str, float]:
        """Calculate scores for each possible field based on subject grades."""
        grade_values = {'A': 4.0, 'B': 3.0, 'C': 2.0, 'S': 1.0, 'F': 0.0}
        numeric_grades = {k: grade_values[v] for k, v in subjects.items()}
        
        # Define subject importance for each field
        field_requirements = {
            # PHYSICAL_SCIENCE fields
            'Engineering': {
                'Combined Mathematics': 2.0,
                'Physics': 1.5,
                'Chemistry': 1.0,
                'min_grades': {'Combined Mathematics': 'B', 'Physics': 'C'}
            },
            'Computer_Science': {
                'Combined Mathematics': 1.8,
                'Physics': 1.2,
                'Chemistry': 0.8,
                'min_grades': {'Combined Mathematics': 'C'}
            },
            'Mathematics': {
                'Combined Mathematics': 2.5,
                'Physics': 1.0,
                'Chemistry': 0.5,
                'min_grades': {'Combined Mathematics': 'B'}
            },
            'Physics': {
                'Physics': 2.0,
                'Combined Mathematics': 1.5,
                'Chemistry': 1.0,
                'min_grades': {'Physics': 'B', 'Combined Mathematics': 'C'}
            },
            
            # BIOLOGICAL_SCIENCE fields
            'Medicine': {
                'Biology': 2.0,
                'Chemistry': 1.8,
                'Physics': 1.0,
                'min_grades': {'Biology': 'B', 'Chemistry': 'B'}
            },
            'Bio_Science': {
                'Biology': 2.0,
                'Chemistry': 1.5,
                'Physics': 1.0,
                'min_grades': {'Biology': 'C', 'Chemistry': 'C'}
            },
            'Agriculture': {
                'Biology': 1.8,
                'Chemistry': 1.5,
                'Physics': 1.0,
                'min_grades': {'Biology': 'C'}
            },
            'Veterinary_Science': {
                'Biology': 2.0,
                'Chemistry': 1.5,
                'Physics': 1.0,
                'min_grades': {'Biology': 'B', 'Chemistry': 'C'}
            },
            'Dentistry': {
                'Biology': 2.0,
                'Chemistry': 1.8,
                'Physics': 1.0,
                'min_grades': {'Biology': 'B', 'Chemistry': 'B'}
            },
            
            # COMMERCE fields
            'Accounting': {
                'Business Studies': 2.0,
                'Economics': 1.5,
                'Accounting': 2.0,
                'min_grades': {'Accounting': 'C'}
            },
            'Business_Administration': {
                'Business Studies': 2.0,
                'Economics': 1.8,
                'Accounting': 1.5,
                'min_grades': {'Business Studies': 'C'}
            },
            'Economics': {
                'Economics': 2.5,
                'Business Studies': 1.5,
                'Accounting': 1.0,
                'min_grades': {'Economics': 'C'}
            },
            'Finance': {
                'Accounting': 2.0,
                'Economics': 2.0,
                'Business Studies': 1.5,
                'min_grades': {'Accounting': 'C', 'Economics': 'C'}
            },
            'Management': {
                'Business Studies': 2.0,
                'Economics': 1.5,
                'Accounting': 1.5,
                'min_grades': {'Business Studies': 'C'}
            },
            
            # TECHNOLOGY fields
            'Engineering_Technology': {
                'Engineering Technology': 2.0,
                'Science for Technology': 1.5,
                'min_grades': {'Engineering Technology': 'C'}
            },
            'Bio_Systems_Technology': {
                'Bio Systems Technology': 2.0,
                'Science for Technology': 1.5,
                'min_grades': {'Bio Systems Technology': 'C'}
            },
            'Information_Technology': {
                'Engineering Technology': 1.8,
                'Science for Technology': 1.5,
                'min_grades': {'Engineering Technology': 'C'}
            },
            'Industrial_Technology': {
                'Engineering Technology': 2.0,
                'Science for Technology': 1.5,
                'min_grades': {'Engineering Technology': 'C'}
            },
            'Food_Technology': {
                'Bio Systems Technology': 2.0,
                'Science for Technology': 1.5,
                'min_grades': {'Bio Systems Technology': 'C'}
            },
            
            # ARTS fields
            'Education': {
                'Logic and Scientific Method': 1.5,
                'Languages': 1.5,
                'min_grades': {}
            },
            'Languages': {
                'Languages': 2.5,
                'min_grades': {'Languages': 'C'}
            },
            'Law': {
                'Logic and Scientific Method': 2.0,
                'Languages': 1.8,
                'min_grades': {'Logic and Scientific Method': 'C', 'Languages': 'C'}
            },
            'Fine_Arts': {
                'Art': 2.5,
                'Languages': 1.0,
                'min_grades': {'Art': 'C'}
            },
            'Media_Studies': {
                'Languages': 2.0,
                'Art': 1.5,
                'min_grades': {'Languages': 'C'}
            },
            'Social_Sciences': {
                'Logic and Scientific Method': 1.8,
                'Languages': 1.5,
                'min_grades': {'Logic and Scientific Method': 'C'}
            }
        }
        
        fields = config.UNIVERSITY_FIELDS[stream]['fields']
        field_scores = {}
        
        for field in fields:
            if field not in field_requirements:
                continue
                
            requirements = field_requirements[field]
            score = 0
            valid = True
            
            # Check minimum grade requirements
            min_grades = requirements.get('min_grades', {})
            for subject, min_grade in min_grades.items():
                if subject not in subjects:  # If required subject is missing, still allow but with penalty
                    score -= 2.0  # Penalty for missing required subject
                    continue
                if grade_values[subjects[subject]] < grade_values[min_grade]:
                    valid = False
                    break
            
            if not valid:
                continue
            
            # Calculate weighted score
            subject_scores = 0
            subject_weights = 0
            for subject, weight in requirements.items():
                if subject != 'min_grades':
                    if subject in subjects:
                        subject_scores += numeric_grades[subject] * weight
                        subject_weights += weight
                    else:
                        score -= 0.5  # Small penalty for missing non-required subject
            
            # Normalize score by weights if any subjects were found
            if subject_weights > 0:
                score += subject_scores / subject_weights
            
            # Add some randomness based on overall performance
            avg_grade = sum(numeric_grades.values()) / len(numeric_grades)
            randomness = np.random.normal(0, 0.3 * (1 - avg_grade/4.0))  # Less randomness for high performers
            score += randomness
            
            # Ensure non-negative score with minimum threshold
            field_scores[field] = max(0.1, score)  # Small minimum score to avoid zero probabilities
        
        return field_scores

    def generate_university_data(self, stream: str, subjects: Dict[str, str]) -> Dict[str, Any]:
        """Generate university data based on A/L stream and subject grades."""
        field_scores = self._calculate_field_scores(stream, subjects)
        
        if not field_scores or sum(field_scores.values()) == 0:  # If no fields meet requirements or all scores are 0
            fields = config.UNIVERSITY_FIELDS[stream]['fields']
            weights = config.UNIVERSITY_FIELDS[stream]['weights']
            field = np.random.choice(fields, p=[weights[f] for f in fields])
        else:
            # Convert scores to probabilities
            total_score = sum(field_scores.values())
            probabilities = {f: s/total_score for f, s in field_scores.items()}
            
            # Select field based on scores
            field = max(probabilities.items(), key=lambda x: x[1])[0]
            
            # Small chance to pick another field that meets requirements
            if np.random.random() < 0.2:  # 20% chance
                field = np.random.choice(
                    list(field_scores.keys()),
                    p=[field_scores[f]/total_score for f in field_scores.keys()]
                )
        
        return {
            'field': field,
            'year': np.random.randint(1, 5)
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
                student_data['al_results']['stream'],
                student_data['al_results']['subjects']
            )
        
        return student_data
    
    def generate_dataset(self, size=6000):
        """Generate a synthetic dataset for training."""
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
        
        key_subjects = ['mathematics', 'science', 'english', 'sinhala']
        key_subjects = [subj for subj in key_subjects if subj in df.columns]
        if key_subjects:
            grade_map = {
                'A': 4,
                'B': 3,
                'C': 2,
                'S': 1,
                'F': 0
            }
            numeric_df = df[key_subjects].apply(lambda x: x.map(grade_map)).infer_objects(copy=False)
            corr_matrix = numeric_df.corr()
        
        return df
