# Data Collection Schema

## Student Categories
1. After O/L (Grade 11)
2. During A/L (Grade 12-13)
3. After A/L
4. University Student/Graduate

## Core Data Points

### 1. Academic Performance (Required)
```python
academic_data = {
    "ol_results": {
        # Core Subjects (Required)
        "mathematics": float,  # 0-100
        "science": float,
        "english": float,
        
        # Optional but important
        "first_language": float,  # Sinhala/Tamil
        "ict": float,
        
        # Aggregate
        "total_subjects_passed": int,  # 0-9
        "core_subjects_average": float
    },
    
    "al_stream": str,  # Only if applicable
    "al_results": {  # Only if applicable
        # Stream-specific subjects (only relevant stream required)
        "physical_science": {
            "physics": float,
            "combined_maths": float,
            "chemistry": float
        },
        "biological_science": {
            "biology": float,
            "physics": float,
            "chemistry": float
        },
        "commerce": {
            "business_studies": float,
            "accounting": float,
            "economics": float
        },
        "arts": {
            "subject1": float,
            "subject2": float,
            "subject3": float
        },
        "zscore": float  # If available
    },
    
    "university_data": {  # For university students/graduates
        # Core Information
        "degree_type": str,  # "Bachelors", "Masters", "PhD"
        "current_year": int,  # 1-4 for undergrads
        "field_of_study": str,  # Main field
        "specialization": str,  # Specific focus
        
        # Performance Metrics
        "current_gpa": float,  # 0.0-4.0
        "major_specific_grades": {
            "core_subject1": float,
            "core_subject2": float,
            "core_subject3": float
        },
        
        # Technical Skills (Rate 1-5)
        "technical_competencies": {
            "programming": int,
            "data_analysis": int,
            "research": int,
            "domain_specific_tool1": int,
            "domain_specific_tool2": int
        },
        
        # Projects/Research
        "significant_projects": List[{
            "type": str,  # "Research", "Project", "Internship"
            "domain": str,  # Field of work
            "duration_months": int
        }],
        
        # Industry Exposure
        "internships": List[{
            "field": str,
            "duration_months": int,
            "role_type": str  # "Technical", "Research", "Management"
        }]
    }
}
```

### 2. Skills Assessment (Required)
```python
skills_data = {
    # Rate 1-5 (Self assessment)
    "analytical_thinking": int,
    "problem_solving": int,
    "creativity": int,
    "communication": int,
    
    # Boolean flags
    "programming_experience": bool,
    "leadership_experience": bool
}
```

### 3. Interests (Required)
```python
interests_data = {
    # Primary Interest Areas (Select top 3)
    "primary_interests": List[str],  # From predefined categories
    
    # Subject Preferences (Rate 1-5)
    "math_preference": int,
    "science_preference": int,
    "arts_preference": int,
    "commerce_preference": int
}
```

### 4. Constraints (Optional)
```python
constraints = {
    "preferred_location": str,  # District
    "financial_constraints": bool,
    "willing_to_relocate": bool
}
```

### 5. Career Preferences (Required for University Level)
```python
career_preferences = {
    # Career Type
    "preferred_roles": List[str],  # Top 3 from predefined list
    "preferred_sectors": List[str],  # Top 3 from predefined list
    
    # Work Style
    "work_preferences": {
        "research_oriented": bool,
        "industry_oriented": bool,
        "entrepreneurship_interest": bool
    },
    
    # Growth Path
    "career_goals": {
        "further_studies": bool,
        "industry_experience": bool,
        "startup_plans": bool
    }
}
```

## Predefined Categories

### Interest Areas
1. Technology & Computing
2. Engineering & Mathematics
3. Natural Sciences
4. Healthcare & Medicine
5. Business & Finance
6. Arts & Design
7. Social Sciences
8. Education & Teaching
9. Law & Legal Studies
10. Media & Communication

### Career Paths Categories
1. Academic/Research
2. Professional/Technical
3. Business/Management
4. Creative/Design
5. Public Service

### Field-Specific Technical Competencies
1. **Engineering**
   - CAD/CAM
   - Circuit Design
   - Structural Analysis
   - Control Systems

2. **Computer Science**
   - Programming Languages
   - Database Management
   - System Design
   - Machine Learning

3. **Business/Management**
   - Financial Analysis
   - Market Research
   - Project Management
   - Business Strategy

4. **Science**
   - Lab Techniques
   - Research Methods
   - Data Analysis
   - Scientific Writing

### Career Paths for University Students
1. **Research & Development**
   - Academic Research
   - Industrial R&D
   - Research Labs
   - Think Tanks

2. **Industry Positions**
   - Technical Specialist
   - Product Development
   - Consulting
   - Management Trainee

3. **Entrepreneurship**
   - Tech Startups
   - Consulting Firms
   - Innovation Labs
   - Social Enterprises

4. **Further Education**
   - Masters Programs
   - PhD Programs
   - Specialized Certifications
   - Professional Qualifications

## Data Collection Strategy

### Minimum Required Data
1. O/L results (core subjects)
2. Top 3 interests
3. Basic skills assessment

### Optional Enrichment Data
1. A/L results (if available)
2. Extracurricular activities
3. Constraints and preferences

### Essential Data for University Level (Must Have)
1. Degree and specialization
2. Current GPA
3. Core subject performance
4. Key technical skills
5. Career preferences

### Supporting Data for University Level (Adds Value)
1. Project experience
2. Internship details
3. Research exposure
4. Technical certifications

### Optional Data for University Level (Nice to Have)
1. Extracurricular activities
2. Leadership roles
3. Professional networks
4. Industry contacts

## Rationale for Data Points

### Critical Factors
1. **Mathematics & Science Performance**
   - Strong indicator for technical/professional paths
   - Required for most higher education programs

2. **English Proficiency**
   - Essential for higher education
   - Important for global career opportunities

3. **Core Skills**
   - Analytical thinking: Key for academic success
   - Problem-solving: Universal career requirement
   - Communication: Essential soft skill

4. **Primary Interests**
   - Strong predictor of career satisfaction
   - Indicator of natural aptitude

### Minimized Data Collection
1. Removed:
   - Detailed personality assessments
   - Extensive background information
   - Detailed extracurricular history
   - Parent/family information

2. Simplified:
   - Skills to basic self-assessment
   - Interests to top 3 choices
   - Academic data to core subjects

### Critical Factors for University Level Predictions

### 1. Academic Standing
- GPA (Strong indicator of academic capability)
- Performance in core subjects
- Project/Research experience

### 2. Technical Competency
- Field-specific skills
- Technical tool proficiency
- Practical application experience

### 3. Industry Alignment
- Internship experience
- Project portfolio
- Industry-specific skills

### 4. Career Direction
- Research vs Industry preference
- Entrepreneurial inclination
- Further education plans

## Usage Guidelines

### Data Collection Process
1. **Stage 1: Core Data**
   - O/L results
   - Basic skills assessment
   - Primary interests

2. **Stage 2: Stream-Specific Data**
   - A/L stream and results
   - Specialized skills
   - Career preferences

3. **Stage 3: Refinement**
   - Constraints
   - Additional qualifications
   - Specific preferences

### Data Validation Rules
1. **Academic Scores**
   - Values between 0-100
   - Core subjects required
   - Z-score validation if provided

2. **Skills Assessment**
   - Values 1-5 only
   - No missing core skills

3. **Interests**
   - Exactly 3 primary interests
   - Must be from predefined categories

## Implementation Notes

### Data Storage
```python
student_profile = {
    "student_id": str,
    "education_level": str,  # O/L, A/L, Graduate
    "academic_data": academic_data,
    "skills_data": skills_data,
    "interests_data": interests_data,
    "constraints": constraints,  # Optional
    "career_preferences": career_preferences  # For university level
}
```

### Feature Engineering Priorities
1. Academic performance aggregates
2. Skills profile scoring
3. Interest alignment metrics
4. Location-based opportunity scoring

### Feature Engineering for University Level
1. **Technical Proficiency Score**
   ```python
   tech_score = weighted_average([
       technical_competencies,
       project_complexity,
       practical_experience
   ])
   ```

2. **Career Path Alignment**
   ```python
   alignment_score = calculate_alignment(
       student_profile=profile,
       career_path=path,
       weights={
           'academic': 0.3,
           'technical': 0.3,
           'experience': 0.2,
           'preferences': 0.2
       }
   )
   ```

3. **Growth Potential**
   ```python
   growth_score = assess_potential(
       academic_performance,
       technical_skills,
       industry_exposure,
       research_capability
   )
   ```

This schema balances:
- Minimal data collection
- Maximum predictive power
- User-friendly input process
- Sri Lankan education context
- Multiple career path possibilities
