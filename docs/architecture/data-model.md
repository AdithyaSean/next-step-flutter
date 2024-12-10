# Data Model Architecture

## Core Entity: Student

```json
{
    "student": {
        "profile": {
            "id": "UUID",
            "basic_info": {
                "name": "string",
                "dob": "date",
                "contact": "string",
                "district": "string"
            },
            "academic": {
                "current_level": "OL|AL|UNIVERSITY|GRADUATE",
                "ol_results": {
                    "core_subjects": {
                        "mathematics": "OLGrade",
                        "science": "OLGrade",
                        "first_language": "OLGrade",
                        "english": "OLGrade",
                        "religion": "OLGrade",
                        "history": "OLGrade"
                    },
                    "optional_subjects": {
                        "subject1": {
                            "name": "string",
                            "grade": "OLGrade"
                        },
                        "subject2": {
                            "name": "string",
                            "grade": "OLGrade"
                        },
                        "subject3": {
                            "name": "string",
                            "grade": "OLGrade"
                        }
                    },
                    "aggregate_score": "float"
                },
                "al_results": {
                    "stream": "SCIENCE|COMMERCE|ARTS|TECHNOLOGY",
                    "attempt": "integer",
                    "subjects": {
                        "subject1": {
                            "name": "string",
                            "grade": "ALGrade"
                        },
                        "subject2": {
                            "name": "string",
                            "grade": "ALGrade"
                        },
                        "subject3": {
                            "name": "string",
                            "grade": "ALGrade"
                        },
                        "general_english": "ALGrade",
                        "general_it": "ALGrade"
                    },
                    "z_score": "float",
                    "island_rank": "integer",
                    "district_rank": "integer"
                },
                "university": {
                    "name": "string",
                    "degree": "string",
                    "year": "integer",
                    "semester": "integer",
                    "gpa": "float",
                    "specialization": "string"
                }
            },
            "skills_assessment": {
                "technical": [
                    {
                        "skill": "string",
                        "level": "BEGINNER|INTERMEDIATE|ADVANCED",
                        "verified": "boolean"
                    }
                ],
                "soft": [
                    {
                        "skill": "string",
                        "endorsements": "integer"
                    }
                ]
            },
            "interests": {
                "academic": ["string"],
                "career": ["string"],
                "extracurricular": ["string"]
            }
        },
        "recommendations": {
            "education": {
                "immediate": [
                    {
                        "type": "DEGREE|DIPLOMA|PROFESSIONAL",
                        "institution": "string",
                        "program": "string",
                        "match_score": "float",
                        "requirements": {
                            "z_score": "float",
                            "ol_requirements": {
                                "subject": "string",
                                "minimum_grade": "OLGrade"
                            }[],
                            "al_requirements": {
                                "subject": "string",
                                "minimum_grade": "ALGrade"
                            }[]
                        },
                        "career_prospects": ["string"]
                    }
                ],
                "future": [
                    {
                        "type": "MASTERS|PHD|PROFESSIONAL",
                        "prerequisites": ["string"],
                        "timeline": "string"
                    }
                ]
            },
            "career": [
                {
                    "field": "string",
                    "roles": ["string"],
                    "match_score": "float",
                    "requirements": {
                        "education": ["string"],
                        "skills": ["string"],
                        "experience": "string"
                    },
                    "salary_range": {
                        "min": "integer",
                        "max": "integer"
                    }
                }
            ]
        },
        "progress": {
            "assessments": [
                {
                    "date": "timestamp",
                    "type": "APTITUDE|PERSONALITY|SKILLS",
                    "score": "float",
                    "details": "json"
                }
            ],
            "goals": [
                {
                    "type": "EDUCATION|CAREER|SKILL",
                    "description": "string",
                    "deadline": "date",
                    "status": "PENDING|IN_PROGRESS|COMPLETED",
                    "progress_metrics": "json"
                }
            ]
        }
    }
}
```

## Update System (Student-Centric)

### 1. Profile Updates
```json
{
    "type": "PROFILE_UPDATE",
    "data": {
        "academic": {
            "new_results": true,
            "new_achievements": true
        },
        "skills": {
            "added": ["new_skill"],
            "removed": ["old_skill"]
        }
    }
}
```

### 2. Recommendation Updates
```json
{
    "type": "RECOMMENDATION_UPDATE",
    "student_id": "UUID",
    "triggers": {
        "new_results": true,
        "new_interests": true,
        "market_changes": false
    },
    "areas": ["education", "career"]
}
```

### 3. Progress Updates
```json
{
    "type": "PROGRESS_UPDATE",
    "student_id": "UUID",
    "data": {
        "new_assessment": {
            "type": "SKILL_TEST",
            "score": 85
        },
        "goal_status": {
            "goal_id": "UUID",
            "new_status": "COMPLETED"
        }
    }
}
```

## Database Schema

```sql
-- Core Student Table
CREATE TABLE students (
    id TEXT PRIMARY KEY,
    profile JSON,           -- Basic info + academic
    last_updated TIMESTAMP
);

-- Recommendations
CREATE TABLE student_recommendations (
    id TEXT PRIMARY KEY,
    student_id TEXT,
    type TEXT,             -- 'education' or 'career'
    data JSON,
    match_score FLOAT,
    last_updated TIMESTAMP,
    FOREIGN KEY(student_id) REFERENCES students(id)
);

-- Progress Tracking
CREATE TABLE student_progress (
    id TEXT PRIMARY KEY,
    student_id TEXT,
    type TEXT,             -- 'assessment' or 'goal'
    data JSON,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY(student_id) REFERENCES students(id)
);

-- Update Queue
CREATE TABLE update_queue (
    id TEXT PRIMARY KEY,
    student_id TEXT,
    type TEXT,             -- 'profile', 'recommendation', 'progress'
    priority TEXT,         -- 'high', 'normal', 'low'
    status TEXT,           -- 'pending', 'processing', 'completed'
    data JSON,
    created_at TIMESTAMP,
    FOREIGN KEY(student_id) REFERENCES students(id)
);
```

## Module Organization

```
src/
├── student/
│   ├── profile/
│   │   ├── ProfileService.java
│   │   ├── ProfileRepository.java
│   │   └── ProfileController.java
│   ├── recommendation/
│   │   ├── RecommendationService.java
│   │   ├── RecommendationRepository.java
│   │   └── RecommendationController.java
│   └── progress/
│       ├── ProgressService.java
│       ├── ProgressRepository.java
│       └── ProgressController.java
├── ml/
│   ├── predictor/
│   │   └── CareerPredictor.java
│   └── analyzer/
│       └── SkillAnalyzer.java
└── common/
    ├── update/
    │   └── UpdateManager.java
    └── utils/
        └── DataValidator.java
```

## Update Flow

1. **Profile Updates**
   - Student updates their profile
   - System validates changes
   - Triggers recommendation refresh if needed

2. **Automatic Updates**
   - ML model processes new data
   - Generates fresh recommendations
   - Updates stored in queue for sync

3. **Sync Process**
   - App checks for updates on launch
   - Downloads high-priority updates first
   - Updates local database
