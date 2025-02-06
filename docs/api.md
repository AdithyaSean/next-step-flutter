```http
GET http://localhost:8080/students/profile
Content-Type: application/json
UUID: c8d81836-5d5f-43f7-b641-135e36ac4c00

###

POST http://localhost:8080/students
Content-Type: application/json

{
  "username": "student2",
  "name": "student2",
  "email": "student2@example.com",
  "password": "securepassword",
  "telephone": "1234567890",
  "role": "STUDENT",
  "school": "blabla High",
  "district": "blabla School District"
}

###

GET http://localhost:8080/students
Content-Type: application/json

###

PUT http://localhost:8080/students/profile
Content-Type: application/json
UUID: 9fcedb42-7472-4685-9186-9978408aa932

{
  "educationLevel": 2,
  "olResults": {
    "Math": 90.0,
    "Science": 90.0,
    "English": 90.0,
    "History": 90.0,
    "Sinhala": 90.0,
    "Religion": 90.0
  },
  "alStream": 0,
  "alResults": {
    "Physics": 90.0,
    "Chemistry": 90.0,
    "Combined_Maths": 90.0
  },
  "gpa": 4.0
}

###

GET http://localhost:8080/students/profile
Content-Type: application/json
UUID: c8d81836-5d5f-43f7-b641-135e36ac4c00

###
