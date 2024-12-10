# Sri Lankan Education System Analysis

## 1. O/L (Ordinary Level)

### Core Subjects (Mandatory)
1. Mathematics
2. Science
3. Sinhala/Tamil (First Language)
4. English
5. Religion
6. History

### Optional Subjects (Choose 3)
1. ICT
2. Commerce
3. Geography
4. Literature (Sinhala/Tamil/English)
5. Second Language (Tamil/Sinhala)
6. Art
7. Music
8. Dancing
9. Drama
10. Agriculture
11. Home Science

### Grading System
```java
public enum OLGrade {
    A(4),      // 75-100
    B(3),      // 65-74
    C(2),      // 45-64
    S(1),      // 35-44
    F(0);      // 0-34
    
    private final int value;
}
```

## 2. A/L (Advanced Level)

### Streams
1. **Science**
   - Combined Mathematics
   - Physics
   - Chemistry
   - Biology (Optional)
   - ICT (Optional)

2. **Commerce**
   - Business Studies
   - Accounting
   - Economics
   - ICT (Optional)

3. **Arts**
   - Various subject combinations
   - Languages
   - Social Sciences
   - Aesthetics

4. **Technology**
   - Engineering Technology
   - Science for Technology
   - ICT

### Grading System
```java
public enum ALGrade {
    A(4.0),    // 75-100
    B(3.0),    // 65-74
    C(2.0),    // 45-64
    S(1.0),    // 35-44
    F(0.0);    // 0-34
    
    private final double value;
}
```

### Z-Score Calculation
```java
public class ZScore {
    private double rawMark;
    private double mean;
    private double standardDeviation;
    
    public double calculate() {
        return (rawMark - mean) / standardDeviation;
    }
}
```

## 3. University

### Common GPAs
- First Class: 3.70 - 4.00
- Second Upper: 3.30 - 3.69
- Second Lower: 3.00 - 3.29
- Pass: 2.00 - 2.99

## Data Model

```java
@Entity
public class AcademicProfile {
    @Id
    private UUID id;
    
    // O/L Results
    @Embedded
    private OLResults olResults;
    
    // A/L Results
    @Embedded
    private ALResults alResults;
    
    // University Results (if applicable)
    @Embedded
    private UniversityResults uniResults;
}

@Embeddable
public class OLResults {
    private Map<String, OLGrade> coreSubjects;
    private Map<String, OLGrade> optionalSubjects;
    private double aggregateScore;
    
    public boolean isEligibleForALScience() {
        return coreSubjects.get("Mathematics").getValue() >= OLGrade.C.getValue()
            && coreSubjects.get("Science").getValue() >= OLGrade.C.getValue();
    }
    
    public boolean isEligibleForALCommerce() {
        return coreSubjects.get("Mathematics").getValue() >= OLGrade.S.getValue();
    }
}

@Embeddable
public class ALResults {
    private String stream;
    private Map<String, ALGrade> subjects;
    private double zScore;
    
    public List<String> getEligibleDegrees() {
        switch(stream) {
            case "SCIENCE":
                return evaluateSciencePathways();
            case "COMMERCE":
                return evaluateCommercePathways();
            // ... other streams
        }
    }
}

@Embeddable
public class UniversityResults {
    private String degree;
    private double gpa;
    private int year;
    private String specialization;
}
```

## Career Pathway Analysis

### Science Stream Impact
```json
{
    "stream": "SCIENCE",
    "pathways": {
        "engineering": {
            "requirements": {
                "z_score_min": 1.8,
                "subjects": {
                    "combined_maths": ["A", "B"],
                    "physics": ["A", "B", "C"],
                    "chemistry": ["A", "B", "C"]
                }
            }
        },
        "medicine": {
            "requirements": {
                "z_score_min": 2.0,
                "subjects": {
                    "biology": ["A", "B"],
                    "chemistry": ["A", "B"],
                    "physics": ["A", "B", "C"]
                }
            }
        },
        "it": {
            "requirements": {
                "z_score_min": 1.5,
                "subjects": {
                    "combined_maths": ["A", "B", "C"],
                    "physics": ["A", "B", "C"]
                }
            }
        }
    }
}
```

### Commerce Stream Impact
```json
{
    "stream": "COMMERCE",
    "pathways": {
        "business": {
            "requirements": {
                "z_score_min": 1.5,
                "subjects": {
                    "business_studies": ["A", "B"],
                    "accounting": ["A", "B", "C"],
                    "economics": ["A", "B", "C"]
                }
            }
        },
        "banking": {
            "requirements": {
                "z_score_min": 1.7,
                "subjects": {
                    "accounting": ["A", "B"],
                    "economics": ["A", "B"]
                }
            }
        }
    }
}
```

## Recommendation Engine

```java
public class CareerPathwayAnalyzer {
    public List<CareerRecommendation> analyzePathways(AcademicProfile profile) {
        List<CareerRecommendation> recommendations = new ArrayList<>();
        
        // 1. Check O/L qualifications
        if (!profile.getOlResults().meetsBasicRequirements()) {
            return recommendations;
        }
        
        // 2. Analyze A/L results if available
        if (profile.hasALResults()) {
            ALResults alResults = profile.getAlResults();
            switch(alResults.getStream()) {
                case "SCIENCE":
                    recommendations.addAll(analyzeSciencePathways(alResults));
                    break;
                case "COMMERCE":
                    recommendations.addAll(analyzeCommercePathways(alResults));
                    break;
                // ... other streams
            }
        }
        
        // 3. Consider university results if available
        if (profile.hasUniversityResults()) {
            recommendations.addAll(
                analyzePostgraduatePathways(profile.getUniversityResults())
            );
        }
        
        return recommendations;
    }
    
    private List<CareerRecommendation> analyzeSciencePathways(ALResults results) {
        List<CareerRecommendation> paths = new ArrayList<>();
        
        // Engineering pathway
        if (results.getZScore() >= 1.8 
            && results.hasRequiredGrades("combined_maths", Arrays.asList(ALGrade.A, ALGrade.B))) {
            paths.add(new CareerRecommendation("Engineering", 0.9));
        }
        
        // IT pathway
        if (results.getZScore() >= 1.5 
            && results.hasRequiredGrades("combined_maths", Arrays.asList(ALGrade.A, ALGrade.B, ALGrade.C))) {
            paths.add(new CareerRecommendation("Information Technology", 0.85));
        }
        
        return paths;
    }
}
```
