"""Test suite for the student data generation and processing pipeline."""

import unittest
import numpy as np
from pathlib import Path
import sys
from collections import defaultdict
from pprint import pprint

# Add project root to Python path
project_root = Path(__file__).parent.parent
sys.path.append(str(project_root))

from src.data.generators import StudentDataGenerator, config
from src.data.preprocessor import DataPreprocessor

class TestDataPipeline(unittest.TestCase):
    """Test cases for data generation and preprocessing."""
    
    def setUp(self):
        """Set up test fixtures."""
        print("\n" + "="*50)
        print("Setting up test environment...")
        # Use a fixed seed for reproducibility in tests
        self.generator = StudentDataGenerator(seed=42)
        self.preprocessor = DataPreprocessor()
        
        # Generate and save a sample profile for inspection
        self.sample_profile = self.generator.generate_student()
        print("\nGenerated Sample Profile:")
        pprint(self.sample_profile)
        print("="*50)
    
    def test_grade_generation(self):
        """Test if generated grades are valid."""
        print("\nTesting Grade Generation:")
        grades = []
        for _ in range(100):  # Generate 100 grades to check distribution
            grade = self.generator._generate_grade()
            grades.append(grade)
            self.assertIn(grade, config.GRADES)
        
        # Print grade distribution
        grade_dist = {grade: grades.count(grade)/len(grades) for grade in config.GRADES}
        print("Grade Distribution:", grade_dist)
    
    def test_ol_results(self):
        """Test O/L results generation."""
        print("\nTesting O/L Results Generation:")
        ol_results = self.generator.generate_ol_results()
        print("\nGenerated O/L Results:")
        pprint(ol_results)
        
        # Verify all core subjects are present
        for subject in config.OL_SUBJECTS:
            self.assertIn(subject, ol_results)
            self.assertIn(ol_results[subject], config.GRADES)
        
        # Verify no extra subjects
        self.assertEqual(
            set(ol_results.keys()),
            set(config.OL_SUBJECTS),
            "Extra subjects found in O/L results"
        )
    
    def test_al_results(self):
        """Test A/L results generation."""
        print("\nTesting A/L Results Generation:")
        
        # Test multiple profiles to check subject distribution
        profiles = defaultdict(int)
        optional_subjects = defaultdict(lambda: defaultdict(int))
        
        num_samples = 100
        for _ in range(num_samples):
            al_results = self.generator.generate_al_results()
            stream = al_results['stream']
            profiles[stream] += 1
            
            if stream == 'ARTS':
                # Verify Arts stream has exactly 3 subjects
                self.assertEqual(
                    len(al_results['subjects']), 3,
                    "Arts stream should have exactly 3 subjects"
                )
                
                # Verify subjects are from correct groups
                subjects = set(al_results['subjects'].keys())
                all_valid_subjects = set()
                for group in config.AL_STREAMS['ARTS']['groups'].values():
                    all_valid_subjects.update(group['subjects'])
                
                self.assertTrue(
                    subjects.issubset(all_valid_subjects),
                    f"Invalid Arts subjects found: {subjects - all_valid_subjects}"
                )
            else:
                # Verify compulsory subjects
                stream_config = config.AL_STREAMS[stream]
                subjects = al_results['subjects']
                
                for subject in stream_config['compulsory']:
                    self.assertIn(
                        subject, subjects,
                        f"Missing compulsory subject {subject} in {stream}"
                    )
                
                # Track optional subject distribution
                optional_subjects_set = set(subjects.keys()) - set(stream_config['compulsory'])
                self.assertEqual(
                    len(optional_subjects_set), 1,
                    f"Expected exactly 1 optional subject, got {len(optional_subjects_set)}"
                )
                optional_subject = list(optional_subjects_set)[0]
                optional_subjects[stream][optional_subject] += 1
        
        # Print distribution statistics
        print("\nStream Distribution:")
        for stream, count in profiles.items():
            print(f"{stream}: {count/num_samples:.2%}")
        
        print("\nOptional Subject Distribution by Stream:")
        for stream, subjects in optional_subjects.items():
            print(f"\n{stream}:")
            total = sum(subjects.values())
            for subject, count in subjects.items():
                print(f"  {subject}: {count/total:.2%}")
    
    def test_university_data(self):
        """Test university data generation."""
        print("\nTesting University Data Generation:")
        
        # Test field distribution for each stream
        num_samples = 100
        field_distribution = defaultdict(lambda: defaultdict(int))
        
        for stream in config.AL_STREAMS.keys():
            print(f"\nTesting stream: {stream}")
            for _ in range(num_samples):
                uni_data = self.generator.generate_university_data(stream)
                
                # Verify basic structure
                self.assertIn('field_of_study', uni_data)
                self.assertIn('current_year', uni_data)
                self.assertIn('current_gpa', uni_data)
                
                # Verify field is valid for stream
                self.assertIn(
                    uni_data['field_of_study'],
                    config.UNIVERSITY_FIELDS[stream]['fields'],
                    f"Invalid field {uni_data['field_of_study']} for {stream}"
                )
                
                # Track field distribution
                field_distribution[stream][uni_data['field_of_study']] += 1
                
                # Verify year range
                self.assertTrue(1 <= uni_data['current_year'] <= 4)
                
                # Verify GPA range
                self.assertTrue(2.0 <= uni_data['current_gpa'] <= 4.0)
        
        # Print field distribution statistics
        print("\nField Distribution by Stream:")
        for stream, fields in field_distribution.items():
            print(f"\n{stream}:")
            total = sum(fields.values())
            for field, count in fields.items():
                print(f"  {field}: {count/total:.2%}")
    
    def test_complete_profile(self):
        """Test complete student profile generation."""
        print("\nTesting Complete Profile Generation:")
        profile = self.generator.generate_student()
        print("\nGenerated complete profile:")
        pprint(profile)
        
        # Verify structure
        self.assertIn('student_id', profile)
        self.assertIn('ol_results', profile)
        self.assertIn('al_results', profile)
        self.assertIn('university_data', profile)
        
        # Verify student ID format
        self.assertTrue(profile['student_id'].startswith('ST'))
        self.assertEqual(len(profile['student_id']), 10)
        
        # Verify O/L results
        self.assertEqual(
            set(profile['ol_results'].keys()),
            set(config.OL_SUBJECTS)
        )
        
        # Verify A/L results structure
        al_results = profile['al_results']
        self.assertIn('stream', al_results)
        self.assertIn('subjects', al_results)
        
        # Verify university data matches stream
        uni_data = profile['university_data']
        stream = al_results['stream']
        self.assertIn(
            uni_data['field_of_study'],
            config.UNIVERSITY_FIELDS[stream]['fields']
        )
    
    def test_dataset_generation(self):
        """Test generating multiple profiles."""
        print("\nTesting Dataset Generation:")
        dataset_size = 10
        dataset = self.generator.generate_dataset(dataset_size)
        
        # Verify dataset size
        self.assertEqual(len(dataset), dataset_size)
        
        # Verify all profiles are unique
        student_ids = [profile['student_id'] for profile in dataset]
        self.assertEqual(
            len(set(student_ids)), dataset_size,
            "Duplicate student IDs found"
        )
        
        print(f"\nSuccessfully generated {dataset_size} unique profiles")
        print("Sample profile from dataset:")
        pprint(dataset[0])

if __name__ == '__main__':
    unittest.main()
