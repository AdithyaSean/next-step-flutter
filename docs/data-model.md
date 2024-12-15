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
    private String password;

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
   - Object Relational Mapping
   - Postgresql compatible
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

1. **PostgreSQL Optimization**
   - B-tree indexes for UUID lookups
   - JSONB for flexible storage
   - Materialized views for predictions
   - Trigger-based model updates
   - Connection pooling

2. **Real-time Updates**
   - Database triggers for model notifications
   - WebSocket notifications for clients
   - Optimistic locking
   - Transaction management

3. **Performance**
   - Prepared statements
   - Query planning
   - Index optimization
   - Connection pooling
   - Statement caching

## User Flow
1. Student enters O/L results → Server stores data and triggers model
2. Model updates predictions → Database updated
3. WebSocket notifies client → UI updates automatically
4. User browses recommendations with real-time updates
