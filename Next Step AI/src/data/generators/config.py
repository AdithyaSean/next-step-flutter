"""Configuration for dataset generation."""

# Education Level Distribution
EDUCATION_LEVEL_DIST = {
    'OL': 0.4,    # 40% O/L students
    'AL': 0.3,    # 30% A/L students
    'UNDERGRADUATE': 0.2,  # 20% undergraduates
    'GRADUATE': 0.1  # 10% graduates
}

# Grade Distributions
GRADES = ['A', 'B', 'C', 'S', 'F']  # Updated to match Sri Lankan system
GRADE_PROBABILITIES = {
    'A': 0.15,  # Distinction Pass
    'B': 0.25,  # Very Good Pass
    'C': 0.30,  # Credit Pass
    'S': 0.20,  # Simple Pass
    'F': 0.10   # Fail
}

# O/L Core Subjects (Based on Sri Lankan O/L curriculum)
OL_SUBJECTS = [
    'mathematics',          # Mathematics
    'science',             # Science
    'english',             # English Language
    'sinhala',             # First Language (Sinhala)
    'religion',            # Religion (Buddhism/Hinduism/Islam/Christianity)
    'history'              # History
]

# A/L Streams and Subjects (Updated for Sri Lankan A/L curriculum)
AL_STREAMS = {
    'PHYSICAL_SCIENCE': {
        'compulsory': ['combined_maths', 'physics'],
        'optional': ['chemistry', 'ict', 'agriculture'],
        'weights': {
            'chemistry': 0.7,  # Most common
            'ict': 0.2,
            'agriculture': 0.1
        }
    },
    'BIOLOGICAL_SCIENCE': {
        'compulsory': ['biology', 'chemistry'],
        'optional': ['physics', 'agriculture', 'ict'],
        'weights': {
            'physics': 0.7,    # Most common
            'agriculture': 0.2,
            'ict': 0.1
        }
    },
    'TECHNOLOGY': {
        'compulsory': ['engineering_technology', 'science_for_technology'],
        'optional': ['ict', 'agriculture', 'science_for_tech_optional'],
        'weights': {
            'ict': 0.6,        # Most common
            'agriculture': 0.2,
            'science_for_tech_optional': 0.2
        }
    },
    'COMMERCE': {
        'compulsory': ['business_studies', 'accounting'],
        'optional': ['economics', 'business_statistics', 'ict'],
        'weights': {
            'economics': 0.6,   # Most common
            'business_statistics': 0.3,
            'ict': 0.1
        }
    },
    'ARTS': {
        'groups': {
            'group1': {
                'subjects': ['logic', 'economics', 'geography', 'civics', 'languages'],
                'weights': {
                    'logic': 0.3,
                    'economics': 0.3,
                    'geography': 0.2,
                    'civics': 0.1,
                    'languages': 0.1
                }
            },
            'group2': {
                'subjects': ['political_science', 'history', 'buddhism', 'media_studies'],
                'weights': {
                    'political_science': 0.3,
                    'history': 0.3,
                    'buddhism': 0.2,
                    'media_studies': 0.2
                }
            },
            'group3': {
                'subjects': ['drama', 'art', 'music', 'languages', 'ict'],
                'weights': {
                    'drama': 0.2,
                    'art': 0.2,
                    'music': 0.2,
                    'languages': 0.2,
                    'ict': 0.2
                }
            }
        }
    }
}

# Stream selection weights (equal distribution)
STREAM_WEIGHTS = {
    'PHYSICAL_SCIENCE': 0.2,
    'BIOLOGICAL_SCIENCE': 0.2,
    'TECHNOLOGY': 0.2,
    'COMMERCE': 0.2,
    'ARTS': 0.2
}

# Stream Distribution (Updated with Technology stream)
STREAM_DISTRIBUTION = {
    'PHYSICAL_SCIENCE': 0.20,
    'BIOLOGICAL_SCIENCE': 0.20,
    'TECHNOLOGY': 0.15,     # Added Technology stream
    'COMMERCE': 0.25,
    'ARTS': 0.20
}

# University Fields (Mapped to streams)
UNIVERSITY_FIELDS = {
    'PHYSICAL_SCIENCE': {
        'fields': [
            'Engineering',
            'Computer_Science',
            'Mathematics',
            'Physics',
            'Information_Technology'
        ],
        'weights': {
            'Engineering': 0.3,
            'Computer_Science': 0.3,
            'Mathematics': 0.2,
            'Physics': 0.1,
            'Information_Technology': 0.1
        }
    },
    'BIOLOGICAL_SCIENCE': {
        'fields': [
            'Medicine',
            'Dentistry',
            'Veterinary_Science',
            'Agriculture',
            'Bio_Science'
        ],
        'weights': {
            'Medicine': 0.3,
            'Dentistry': 0.2,
            'Veterinary_Science': 0.2,
            'Agriculture': 0.15,
            'Bio_Science': 0.15
        }
    },
    'TECHNOLOGY': {
        'fields': [
            'Engineering_Technology',
            'Information_Technology',
            'Industrial_Technology',
            'Food_Technology',
            'Bio_Systems_Technology'
        ],
        'weights': {
            'Engineering_Technology': 0.3,
            'Information_Technology': 0.3,
            'Industrial_Technology': 0.2,
            'Food_Technology': 0.1,
            'Bio_Systems_Technology': 0.1
        }
    },
    'COMMERCE': {
        'fields': [
            'Business_Administration',
            'Finance',
            'Accounting',
            'Economics',
            'Management'
        ],
        'weights': {
            'Business_Administration': 0.25,
            'Finance': 0.25,
            'Accounting': 0.2,
            'Economics': 0.15,
            'Management': 0.15
        }
    },
    'ARTS': {
        'fields': [
            'Law',
            'Social_Sciences',
            'Education',
            'Languages',
            'Fine_Arts',
            'Media_Studies'
        ],
        'weights': {
            'Law': 0.2,
            'Social_Sciences': 0.2,
            'Education': 0.2,
            'Languages': 0.15,
            'Fine_Arts': 0.15,
            'Media_Studies': 0.1
        }
    }
}

# Field Distribution within Streams
FIELD_DISTRIBUTION = {
    stream: {field: 1/len(fields) for field in fields}
    for stream, fields in UNIVERSITY_FIELDS.items()
}

# Skills Distribution (mean, std) for 1-5 scale
SKILL_DISTRIBUTIONS = {
    'analytical_thinking': (3.5, 0.8),
    'problem_solving': (3.3, 0.9),
    'creativity': (3.4, 0.7),
    'communication': (3.6, 0.8)
}

# Technical Skills by Field
TECHNICAL_SKILLS = {
    'Computer Science': {
        'programming': (4.0, 0.7),
        'database_management': (3.8, 0.8),
        'web_development': (3.7, 0.9),
        'data_structures': (3.5, 0.8)
    },
    'Engineering': {
        'cad_design': (3.8, 0.7),
        'circuit_analysis': (3.7, 0.8),
        'mechanics': (3.6, 0.9),
        'materials': (3.5, 0.8)
    },
    'Medicine': {
        'clinical_skills': (4.0, 0.6),
        'patient_care': (3.9, 0.7),
        'medical_knowledge': (3.8, 0.8),
        'diagnostics': (3.7, 0.7)
    }
}

# Career Paths with Requirements
CAREER_PATHS = {
    'Software Engineer': {
        'min_ol_maths': 70,
        'min_al_maths': 75,
        'required_skills': ['analytical_thinking', 'problem_solving']
    },
    'Doctor': {
        'min_ol_science': 75,
        'min_al_biology': 80,
        'required_skills': ['analytical_thinking', 'communication']
    },
    'Business Analyst': {
        'min_ol_maths': 65,
        'min_al_accounting': 70,
        'required_skills': ['analytical_thinking', 'communication']
    },
    'Data Scientist': {
        'min_ol_maths': 75,
        'min_al_maths': 80,
        'required_skills': ['analytical_thinking', 'problem_solving']
    },
    'Biomedical Engineer': {
        'min_ol_science': 70,
        'min_al_biology': 75,
        'required_skills': ['problem_solving', 'creativity']
    },
    'Financial Analyst': {
        'min_ol_maths': 70,
        'min_al_accounting': 75,
        'required_skills': ['analytical_thinking', 'problem_solving']
    },
    'Research Scientist': {
        'min_ol_science': 80,
        'min_al_chemistry': 80,
        'required_skills': ['analytical_thinking', 'creativity']
    },
    'Teacher': {
        'min_ol_english': 70,
        'min_al_subject1': 75,
        'required_skills': ['communication', 'creativity']
    },
    'Marketing Manager': {
        'min_ol_english': 75,
        'min_al_business': 70,
        'required_skills': ['communication', 'creativity']
    },
    'Civil Engineer': {
        'min_ol_maths': 70,
        'min_al_maths': 75,
        'required_skills': ['problem_solving', 'analytical_thinking']
    }
}

# Interest Areas
INTEREST_AREAS = {
    'Technology': 0.25,
    'Healthcare': 0.2,
    'Business': 0.2,
    'Education': 0.15,
    'Research': 0.1,
    'Engineering': 0.1
}

# Work Environment Preferences
WORK_ENVIRONMENTS = {
    'Office': 0.4,
    'Remote': 0.2,
    'Field': 0.15,
    'Hospital': 0.15,
    'Laboratory': 0.1
}

# Districts with Population Distribution
DISTRICTS = {
    'Colombo': 0.3,
    'Gampaha': 0.2,
    'Kandy': 0.15,
    'Galle': 0.1,
    'Kurunegala': 0.1,
    'Jaffna': 0.08,
    'Batticaloa': 0.07
}

# Financial Constraints Distribution
FINANCIAL_CONSTRAINTS = {
    True: 0.4,  # 40% have financial constraints
    False: 0.6  # 60% don't have financial constraints
}

# GPA Distribution
GPA_DISTRIBUTION = {
    'mean': 3.2,
    'std': 0.4,
    'min': 2.0,
    'max': 4.0
}

# Project Types with Duration Ranges (in months)
PROJECT_TYPES = {
    'Research': {
        'min_duration': 3,
        'max_duration': 12
    },
    'Project': {
        'min_duration': 2,
        'max_duration': 6
    },
    'Internship': {
        'min_duration': 1,
        'max_duration': 4
    }
}

# Relocation Willingness
RELOCATION_WILLINGNESS = {
    True: 0.7,  # 70% willing to relocate
    False: 0.3
}
