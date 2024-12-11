# Data Model Architecture

## Core Entities

### 1. Student
```java
@Entity
@Table(name = "students")
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    // Basic Info
    private String name;
    private String email;
    private String contact;
    private String school;
    private String district;

    // O/L Results
    @ElementCollection
    private Map<String, String> olResults;  // subject -> grade
    
    // A/L Information (if exists)
    @ElementCollection
    private Map<String, String> alResults;  // subject -> grade
    private String stream;
    private Double zScore;
    
    // Preferences & Skills
    @ElementCollection
    private List<String> interests;
    @ElementCollection
    private List<String> skills;
    @ElementCollection
    private List<String> strengths;  // personality traits, soft skills
}
```

### 2. Stream
```java
@Entity
@Table(name = "streams")
public class Stream {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    private String name;  // e.g., "Physical Science", "Biological Science"
    private String description;
    
    @ElementCollection
    private List<String> requiredOLSubjects;
    @ElementCollection
    private Map<String, String> minimumOLGrades;  // subject -> minimum grade
    
    @OneToMany(mappedBy = "stream")
    private List<Course> possibleCourses;
    
    @ElementCollection
    private List<String> relatedCareers;  // Links to Career.code
    
    private Double predictedProbability;
}
```

### 3. Course
```java
@Entity
@Table(name = "courses")
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    private String name;  // e.g., "Computer Science", "Medicine"
    private String description;
    private String duration;  // e.g., "4 years"
    
    @ManyToOne
    private Stream stream;
    
    @ElementCollection
    private Map<String, String> minimumALGrades;
    private Double minimumZScore;
    
    @ManyToMany
    private List<Institution> offeredBy;
    
    @ElementCollection
    private List<String> relatedCareers;  // Links to Career.code
    
    @ElementCollection
    private List<String> skillsGained;    // Skills obtained from this course
    
    private Double predictedProbability;
}
```

### 4. Institution
```java
@Entity
@Table(name = "institutions")
public class Institution {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    private String name;
    private String type;  // UNIVERSITY, PRIVATE_UNIVERSITY, INSTITUTE
    private String website;
    private String location;
    private String contact;
    
    @ElementCollection
    private Map<String, String> socialLinks;
    
    @ManyToMany(mappedBy = "offeredBy")
    private List<Course> availableCourses;
    
    private String admissionProcess;
    private String facilities;
    
    @ElementCollection
    private List<String> industryPartners;  // Companies for internships/placements
}
```

### 5. Career
```java
@Entity
@Table(name = "careers")
public class Career {
    @Id
    private String code;  // Unique career code
    
    private String title;
    private String description;
    private String industry;
    private String outlook;  // Job market outlook
    
    @ElementCollection
    private List<String> requiredSkills;
    @ElementCollection
    private List<String> recommendedPersonalityTraits;
    
    @ElementCollection
    private List<String> relatedCourses;  // Links to Course names
    
    @ElementCollection
    private Map<String, String> salaryRanges;  // experience_level -> range
    
    @ElementCollection
    private List<String> certifications;  // Recommended certifications
    
    private Double predictedProbability;
}
```

### 6. Prediction
```java
@Entity
@Table(name = "predictions")
public class Prediction {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @ManyToOne
    private Student student;
    private LocalDateTime predictedAt;
    
    @ElementCollection
    private List<PathPrediction> predictedPaths;
    
    @Embeddable
    public static class PathPrediction {
        @ManyToOne
        private Stream stream;
        private Double streamProbability;
        
        @ManyToOne
        private Course course;
        private Double courseProbability;
        
        private String careerCode;  // References Career.code
        private Double careerProbability;
        
        private String reasoning;
        @ElementCollection
        private List<Institution> recommendedInstitutions;
    }
}
```

## Key Features

1. **Integrated Predictions**
   - Stream predictions based on O/L results
   - Course predictions based on stream and A/L results
   - Career predictions based on academic performance, skills, and interests
   - Institution recommendations for each educational path

2. **Career Integration**
   - Careers linked to both streams and courses
   - Skill mapping between courses and careers
   - Personality trait matching
   - Industry and salary information

3. **Comprehensive Student Profile**
   - Academic performance
   - Skills and interests
   - Personality traits
   - Career preferences

4. **Educational Pathways**
   - Clear progression from stream → course → career
   - Multiple pathway possibilities
   - Institution options for each path

5. **Rich Career Information**
   - Job market outlook
   - Salary ranges
   - Required skills
   - Recommended certifications
   - Industry connections

6. **Simple Yet Powerful**
   - Lightweight entities
   - Clear relationships
   - Easy to maintain
   - Scalable structure

## User Flow
1. Student enters O/L results → Get stream predictions
2. Click on stream → See possible courses and related careers
3. Click on course → View institutions and career opportunities
4. Click on career → View requirements, outlook, and salary ranges
5. Click on institution → Get admission details and industry partners
