# Data Model Architecture

## Core Entities

### 1. Student Entity
```java
@Entity
@Table(name = "students")
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @Embedded
    private BasicInfo basicInfo;
    
    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL)
    private List<AcademicRecord> academicRecords;
    
    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL)
    private List<SkillAssessment> skills;
    
    @ElementCollection
    private List<String> interests;
    
    @Embedded
    private SyncMetadata syncMetadata;
}

@Embeddable
public class BasicInfo {
    private String name;
    private LocalDate dob;
    private String contact;
    private String district;
}
```

### 2. Academic Records
```java
@Entity
@Table(name = "academic_records")
public class AcademicRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;
    
    @Enumerated(EnumType.STRING)
    private AcademicLevel level;
    
    @OneToOne(cascade = CascadeType.ALL)
    private OLResults olResults;
    
    @OneToOne(cascade = CascadeType.ALL)
    private ALResults alResults;
    
    @OneToOne(cascade = CascadeType.ALL)
    private UniversityResults universityResults;
    
    @Embedded
    private SyncMetadata syncMetadata;
}

@Entity
public class OLResults {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @ElementCollection
    @MapKeyEnumerated(EnumType.STRING)
    private Map<CoreSubject, Grade> coreSubjects;
    
    @OneToMany(cascade = CascadeType.ALL)
    private List<OptionalSubject> optionalSubjects;
    
    private Double aggregateScore;
}

@Entity
public class ALResults {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @Enumerated(EnumType.STRING)
    private Stream stream;
    
    private Integer attempt;
    
    @OneToMany(cascade = CascadeType.ALL)
    private List<ALSubject> subjects;
    
    private Grade generalEnglish;
    private Grade generalIT;
    
    private Double zScore;
    private Integer districtRank;
    private Integer islandRank;
}
```

### 3. University Program
```java
@Entity
@Table(name = "university_programs")
public class UniversityProgram {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    private String name;
    private String code;
    private String faculty;
    
    @Enumerated(EnumType.STRING)
    private Stream stream;
    
    private Integer duration;
    
    @Embedded
    private CutoffScores cutoffScores;
    
    @OneToMany(cascade = CascadeType.ALL)
    private List<Prerequisite> prerequisites;
    
    @OneToMany(cascade = CascadeType.ALL)
    private List<CareerPath> careerPaths;
    
    @Embedded
    private SyncMetadata syncMetadata;
}
```

### 4. ML Model Metadata
```java
@Entity
@Table(name = "ml_models")
public class MLModel {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    @Enumerated(EnumType.STRING)
    private ModelType modelType;
    
    private String version;
    
    @Embedded
    private Accuracy accuracy;
    
    private LocalDateTime lastTraining;
    
    @ElementCollection
    private List<FeatureImportance> featureImportance;
    
    private String onnxPath;
    private Long sizeBytes;
    
    @Embedded
    private SyncMetadata syncMetadata;
}
```

## Sync System

### 1. Sync Metadata
```java
@Embeddable
public class SyncMetadata {
    private Integer version;
    private LocalDateTime lastModified;
    
    @Enumerated(EnumType.STRING)
    private SyncStatus status;
    
    private String deviceId;
    
    @Embedded
    private ConflictResolution conflictResolution;
}

@Embeddable
public class ConflictResolution {
    @Enumerated(EnumType.STRING)
    private ResolutionStrategy strategy;
    
    private LocalDateTime resolvedAt;
    private String resolvedBy;
}
```

### 2. Sync Queue
```java
@Entity
@Table(name = "sync_queue")
public class SyncQueueItem {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    
    private UUID entityId;
    
    @Enumerated(EnumType.STRING)
    private SyncOperation operation;
    
    @Enumerated(EnumType.STRING)
    private SyncStatus status;
    
    private Integer retryCount;
    private LocalDateTime lastAttempt;
    private String error;
    
    @Column(columnDefinition = "TEXT")
    private String payload;
}
```

## Key Features

1. **SQLite Integration**
   - Lightweight, serverless database
   - Zero-configuration required
   - Full ACID compliance
   - Cross-platform compatibility

2. **Bidirectional Relationships**
   - Proper mapping of parent-child relationships
   - Cascade operations for related entities
   - Efficient querying with indexes

3. **Embedded Components**
   - Common patterns extracted into embeddable classes
   - Reduces duplication and improves maintainability
   - Optimized storage in SQLite

4. **Sync Support**
   - Every entity includes sync metadata
   - Built-in conflict resolution
   - Queue-based sync operations
   - Efficient delta updates

5. **Enum Usage**
   - Strong typing for status, grades, and operations
   - Stored as TEXT in SQLite
   - Ensures data consistency

6. **Local Storage**
   - Fast local access with SQLite
   - Minimal memory footprint
   - Automatic backup support
   - Efficient binary storage
