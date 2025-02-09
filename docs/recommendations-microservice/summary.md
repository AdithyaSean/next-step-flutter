# Recommendations Microservice Documentation

## Overview
The Recommendations Microservice provides career predictions and recommendations based on student academic performance data.

## Student Education Levels
* `0`: O/L (Ordinary Level)
* `1`: A/L (Advanced Level)
* `2`: University

## A/L Streams
* `6`: Physical Science
* `7`: Bio Science
* `8`: ICT + Physical Science
* `9`: Agriculture + Bio Science

## Required Academic Data by Education Level

### O/L Student Profile
* Required Fields:
  - `educationLevel: 0`
  - `olResults`: Map of subject scores
    ```json
    {
      "Maths": 0-100,
      "Science": 0-100,
      "English": 0-100,
      "Sinhala": 0-100,
      "History": 0-100,
      "Religion": 0-100
    }
    ```

### A/L Student Profile
* Required Fields:
  - `educationLevel: 1`
  - `olResults`: All O/L results
  - `alStream`: Stream ID (6, 7, 8, or 9)
  - `alResults`: Three subject scores based on stream

Example Subject Combinations:
1. Physical Science (alStream: 6)
   ```json
   {
     "Physics": 0-100,
     "Chemistry": 0-100,
     "Combined_Maths": 0-100
   }
   ```
2. Bio Science (alStream: 7)
   ```json
   {
     "Biology": 0-100,
     "Chemistry": 0-100,
     "Physics": 0-100
   }
   ```
3. ICT + Physical Science (alStream: 8)
   ```json
   {
     "Combined_Maths": 0-100,
     "Physics": 0-100,
     "ICT": 0-100
   }
   ```
4. Agriculture + Bio Science (alStream: 9)
   ```json
   {
     "Biology": 0-100,
     "Chemistry": 0-100,
     "Agriculture": 0-100
   }
   ```

### University Student Profile
* Required Fields:
  - `educationLevel: 2`
  - `olResults`: All O/L results
  - `alStream`: Previous A/L stream
  - `alResults`: A/L subject scores
  - `gpa`: Current GPA (0.0-4.0)

## Career Prediction API 
The career prediction endpoint is called by the User Management service after a student profile update:

```
POST /predictions/career-prediction
Headers:
  Content-Type: application/json
  UUID: student-uuid

Body: StudentProfileDTO (containing academic data based on education level)

Response:
{
  ...studentProfileDTO,
  "careerProbabilities": {
    "Engineering": 0-100,
    "Medicine": 0-100,
    "IT": 0-100,
    etc.
  }
}
```

## Notes
* All numeric scores are on a scale of 0-100 (except GPA: 0.0-4.0)
* Career predictions are returned as probability percentages 
* The service accounts for the student's current education level when making predictions
* The prediction model considers both O/L and A/L results when available
* For university students, GPA is factored into career predictions
