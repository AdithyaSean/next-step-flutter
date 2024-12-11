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

    // Career Predictions
    @ElementCollection
    private List<CareerPrediction> predictions;
}

@Embeddable
public class CareerPrediction {
    private String careerPath;
    private Double probability;
    private LocalDateTime predictedAt;
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
}
```

### 4. Career
```java
@Entity
@Table(name = "careers")
public class Career {
    @Id
    private String code;  // Unique career code

    private String title;
    private String description;
    private String category;

    @ElementCollection
    private List<String> requiredSkills;

    @ElementCollection
    private List<String> relatedCourses;  // Links to Course.id

    @ElementCollection
    private Map<String, String> externalLinks;  // resource -> URL
}
```

### 5. Institution
```java
@Entity
@Table(name = "institutions")
public class Institution {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private String name;
    private String type;  // e.g., "University", "Institute"
    private String website;
    private String location;

    @ManyToMany(mappedBy = "offeredBy")
    private List<Course> courses;

    @ElementCollection
    private Map<String, String> contactInfo;  // type -> value
}
```

## Design Benefits

1. **Efficient Storage**
   - UUID-based primary keys
   - Map-based storage for grades
   - List-based storage for collections
   - Embedded objects for predictions

2. **Flexible Relationships**
   - Many-to-many course-institution
   - One-to-many stream-course
   - Embedded career predictions
   - External resource links

3. **Rich Features**
   - Multiple grade records
   - Career path predictions
   - External resources
   - Contact information

4. **Easy Integration**
   - Spring Data JPA ready
   - SQLite compatible
   - Flutter serializable
   - REST API friendly

## Key Features

1. **Integrated Predictions**
   - Stream predictions based on O/L results
   - Course predictions based on stream and A/L results
   - Career suggestions with external information links
   - Institution recommendations with website links

2. **Educational Pathways**
   - Clear progression from stream → course → career
   - Multiple pathway possibilities
   - Institution options for each path

3. **External Information Integration**
   - Links to official institution websites
   - Links to career information resources
   - Access to up-to-date career details
   - Direct access to admission information

4. **Student Profile**
   - Academic performance tracking
   - Skills and interests
   - Personality traits
   - Career preferences

5. **Simple Yet Powerful**
   - Lightweight entities
   - Clear relationships
   - Easy to maintain
   - Scalable structure

## Database Design

1. **Efficient Storage**
   - UUID-based primary keys
   - Map-based storage for grades
   - List-based storage for collections
   - Embedded objects for complex types

2. **Relationships**
   - One-to-many: Stream → Courses
   - Many-to-many: Course ↔ Institution
   - Soft links: Career references

3. **Performance**
   - Indexed lookups
   - Denormalized data where needed
   - Efficient queries
   - SQLite optimization

4. **Data Integrity**
   - Foreign key constraints
   - Not-null constraints
   - Unique constraints
   - Check constraints

## User Flow
1. Student enters O/L results → Get stream predictions
2. Click on stream → See possible courses and related careers
3. Click on course → View institutions and career opportunities
4. Click on career → Links to respective information sources
5. Click on institution → Links to respective information sources
