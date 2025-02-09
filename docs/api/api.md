### Create Student Account (Reference)
POST http://localhost:8080/students
Content-Type: application/json

{
  "username": "student1",
  "name": "John Student",
  "email": "student1@example.com", 
  "password": "pass123",
  "telephone": "1234567890",
  "role": "STUDENT",
  "school": "Central School",
  "district": "Western"
}

### Update OL Student Profile
PUT http://localhost:8080/students/profile
Content-Type: application/json
UUID: 550e8400-e29b-41d4-a716-446655440000

{
  "educationLevel": 0,
  "olResults": {
    "Maths": 85.0,
    "Science": 82.0,
    "English": 78.0,
    "Sinhala": 80.0,
    "History": 75.0,
    "Religion": 88.0
  }
}

### Update AL Physical Science Profile
PUT http://localhost:8080/students/profile 
Content-Type: application/json
UUID: 550e8400-e29b-41d4-a716-446655440001

{
  "educationLevel": 1,
  "olResults": {
    "Maths": 90.0,
    "Science": 88.0,
    "English": 85.0,
    "Sinhala": 82.0,
    "History": 78.0,
    "Religion": 85.0
  },
  "alStream": 6,
  "alResults": {
    "Physics": 88.0,
    "Chemistry": 85.0,
    "Combined_Maths": 90.0
  }
}

### Update AL Bio Science Profile
PUT http://localhost:8080/students/profile
Content-Type: application/json  
UUID: 550e8400-e29b-41d4-a716-446655440002

{
  "educationLevel": 1,
  "olResults": {
    "Maths": 85.0,
    "Science": 92.0,
    "English": 88.0,
    "Sinhala": 80.0,
    "History": 75.0,
    "Religion": 85.0
  },
  "alStream": 7,
  "alResults": {
    "Biology": 90.0,
    "Chemistry": 88.0,
    "Physics": 85.0
  }
}

### Update AL Physical Science with ICT Profile
PUT http://localhost:8080/students/profile
Content-Type: application/json
UUID: 550e8400-e29b-41d4-a716-446655440003

{
  "educationLevel": 1,
  "olResults": {
    "Maths": 88.0,
    "Science": 85.0,
    "English": 82.0,
    "Sinhala": 78.0,
    "History": 75.0,
    "Religion": 80.0
  },
  "alStream": 8,
  "alResults": {
    "Combined_Maths": 88.0,
    "Physics": 85.0,
    "ICT": 92.0
  }
}

### Update AL Bio Science with Agriculture Profile
PUT http://localhost:8080/students/profile
Content-Type: application/json
UUID: 550e8400-e29b-41d4-a716-446655440004

{
  "educationLevel": 1,
  "olResults": {
    "Maths": 80.0,
    "Science": 85.0,
    "English": 78.0,
    "Sinhala": 82.0,
    "History": 75.0,
    "Religion": 85.0
  },
  "alStream": 9,
  "alResults": {
    "Biology": 88.0,
    "Chemistry": 85.0,
    "Agriculture": 90.0
  }
}

### Update University Physical Science Profile
PUT http://localhost:8080/students/profile
Content-Type: application/json
UUID: 550e8400-e29b-41d4-a716-446655440005

{
  "educationLevel": 2,
  "olResults": {
    "Maths": 95.0,
    "Science": 92.0,
    "English": 88.0,
    "Sinhala": 85.0,
    "History": 80.0,
    "Religion": 88.0
  },
  "alStream": 6,
  "alResults": {
    "Physics": 92.0,
    "Chemistry": 90.0,
    "Combined_Maths": 95.0
  },
  "gpa": 3.8
}

### Update University Bio Science Profile
PUT http://localhost:8080/students/profile
Content-Type: application/json
UUID: 550e8400-e29b-41d4-a716-446655440006

{
  "educationLevel": 2,
  "olResults": {
    "Maths": 92.0,
    "Science": 95.0,
    "English": 90.0,
    "Sinhala": 88.0,
    "History": 85.0,
    "Religion": 90.0
  },
  "alStream": 7,
  "alResults": {
    "Biology": 95.0,
    "Chemistry": 92.0,
    "Physics": 90.0
  },
  "gpa": 3.9
}

### Update University ICT Profile
PUT http://localhost:8080/students/profile
Content-Type: application/json
UUID: 550e8400-e29b-41d4-a716-446655440007

{
  "educationLevel": 2,
  "olResults": {
    "Maths": 90.0,
    "Science": 88.0,
    "English": 85.0,
    "Sinhala": 82.0, 
    "History": 78.0,
    "Religion": 85.0
  },
  "alStream": 8,
  "alResults": {
    "Combined_Maths": 90.0,
    "Physics": 88.0,
    "ICT": 95.0
  },
  "gpa": 3.7
}

### Update University Agriculture Profile
PUT http://localhost:8080/students/profile
Content-Type: application/json
UUID: 550e8400-e29b-41d4-a716-446655440008

{
  "educationLevel": 2,
  "olResults": {
    "Maths": 85.0,
    "Science": 90.0,
    "English": 82.0,
    "Sinhala": 85.0,
    "History": 80.0,
    "Religion": 88.0
  },
  "alStream": 9,
  "alResults": {
    "Biology": 90.0,
    "Chemistry": 88.0,
    "Agriculture": 95.0
  },
  "gpa": 3.6
}

### Get All Students
GET http://localhost:8080/students
Content-Type: application/json