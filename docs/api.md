# API Documentation for Flutter Frontend

This document provides detailed information about the API endpoints used by the Flutter frontend to interact with the Spring Boot backend. It covers the structure of requests, responses, and error handling for each endpoint.

---

## **1. Overview**

The Flutter frontend communicates with the backend via RESTful APIs. The `StudentService` class in `student_service.dart` handles all HTTP requests, while the backend exposes endpoints for managing student data.

---

## **2. Base URL**

The base URL for all API requests is configurable and passed to the `StudentService` constructor. For example:

```dart
final StudentService studentService = StudentService('http://your-spring-boot-server-url');
```

---

## **3. Endpoints**

### **3.1. Fetch All Students**

- **Endpoint**: `GET /students`
- **Description**: Fetches a list of all students.
- **Request**: No request body.
  - **Response**:
      - **Status Code**: `200 OK`
  - **Body**: A JSON array of student objects.
    ```json
    [
         {
        "id": "123",
        "name": "John Doe",
        "email": "john.doe@example.com",
        "password": "hashedPassword",
        "role": "STUDENT",
        "active": true,
        "createdAt": "2023-10-01T12:00:00Z",
        "updatedAt": "2023-10-01T12:00:00Z",
        "contact": "1234567890",
        "school": "ABC School",
        "district": "Colombo",
        "olResults": {
          "Maths": 85.0,
          "Science": 90.0
        },
        "alResults": {
          "Physics": 75.0,
          "Chemistry": 80.0
        },
        "stream": 1,
         "zScore": 1.5,
         "gpa": 3.8,
        "interests": ["Engineering", "AI"],
        "skills": ["Programming", "Math"],
        "predictions": [
        {
        "careerPath": "Software Engineer",
        "probability": 0.85,
        "predictedAt": "2023-10-01T12:00:00Z"
        }
        ],
        "firebaseUid": "firebaseUid123",
        "firebaseToken": "firebaseToken123"
        }
    ]
    ```

### **3.2. Fetch Student by ID**

- **Endpoint**: `GET /students/{id}`
- **Description**: Fetches a single student by their ID.
- **Request**: No request body.
  - **Response**:
      - **Status Code**: `200 OK`
  - **Body**: A JSON object representing the student.
    ```json
    {
            "id": "123",
            "name": "John Doe",
            "email": "john.doe@example.com",
            "password": "hashedPassword",
            "role": "STUDENT",
            "active": true,
            "createdAt": "2023-10-01T12:00:00Z",
            "updatedAt": "2023-10-01T12:00:00Z",
            "contact": "1234567890",
            "school": "ABC School",
            "district": "Colombo",
            "olResults": {
              "Maths": 85.0,
              "Science": 90.0
            },
            "alResults": {
              "Physics": 75.0,
              "Chemistry": 80.0
            },
            "stream": 1,
            "zScore": 1.5,
            "gpa": 3.8,
            "interests": ["Engineering", "AI"],
            "skills": ["Programming", "Math"],
            "predictions": [
              {
                "careerPath": "Software Engineer",
                "probability": 0.85,
                "predictedAt": "2023-10-01T12:00:00Z"
              }
            ],
            "firebaseUid": "firebaseUid123",
            "firebaseToken": "firebaseToken123"   
    }
    ```

### **3.3. Add a New Student**

- **Endpoint**: `POST /students`
- **Description**: Adds a new student to the database.
  - **Request**:
    - **Body**: A JSON object representing the student.
      ```json
      {
          "id": "123",
          "name": "John Doe",
          "email": "john.doe@example.com",
          "password": "hashedPassword",
          "role": "STUDENT",
          "active": true,
          "createdAt": "2023-10-01T12:00:00Z",
          "updatedAt": "2023-10-01T12:00:00Z",
          "contact": "1234567890",
          "school": "ABC School",
          "district": "Colombo",
          "olResults": {
            "Maths": 85.0,
            "Science": 90.0
          },
          "alResults": {
            "Physics": 75.0,
            "Chemistry": 80.0
          },
          "stream": 1,
          "zScore": 1.5,
          "gpa": 3.8,
          "interests": ["Engineering", "AI"],
          "skills": ["Programming", "Math"],
          "predictions": [
            {
              "careerPath": "Software Engineer",
              "probability": 0.85,
              "predictedAt": "2023-10-01T12:00:00Z"
            }
          ],
          "firebaseUid": "firebaseUid123",
          "firebaseToken": "firebaseToken123"
      }
      ```
- **Response**:
    - **Status Code**: `201 Created`
    - **Body**: No content.

### **3.4. Update an Existing Student**

- **Endpoint**: `PUT /students/{id}`
  - **Description**: Updates an existing student by their ID.
    - **Request**:
      - **Body**: A JSON object representing the updated student.
        ```json
        {
            "id": "123",
            "name": "John Doe",
            "email": "john.doe@example.com",
            "password": "hashedPassword",
            "role": "STUDENT",
            "active": true,
            "createdAt": "2023-10-01T12:00:00Z",
            "updatedAt": "2023-10-01T12:00:00Z",
            "contact": "1234567890",
            "school": "ABC School",
            "district": "Colombo",
            "olResults": {
              "Maths": 85.0,
              "Science": 90.0
            },
            "alResults": {
              "Physics": 75.0,
              "Chemistry": 80.0
            },
            "stream": 1,
            "zScore": 1.5,
            "gpa": 3.8,
            "interests": ["Engineering", "AI"],
            "skills": ["Programming", "Math"],
            "predictions": [
              {
                "careerPath": "Software Engineer",
                "probability": 0.85,
                "predictedAt": "2023-10-01T12:00:00Z"
              }
            ],
            "firebaseUid": "firebaseUid123",
            "firebaseToken": "firebaseToken123"
        }   
        ```
- **Response**:
    - **Status Code**: `200 OK`
    - **Body**: No content.

### **3.5. Delete a Student**

- **Endpoint**: `DELETE /students/{id}`
- **Description**: Deletes a student by their ID.
- **Request**: No request body.
- **Response**:
    - **Status Code**: `204 No Content`
    - **Body**: No content.

---

## **4. Error Handling**

### **4.1. Common Errors**

- **400 Bad Request**: Invalid request body or parameters.
- **404 Not Found**: Student with the specified ID does not exist.
- **500 Internal Server Error**: Server-side error.

### **4.2. Error Response Format**

```json
{
  "timestamp": "2023-10-01T12:00:00Z",
  "status": 404,
  "error": "Not Found",
  "message": "Student with ID 123 not found",
  "path": "/students/123"
}
```

---

## **5. Example Workflow**

### **5.1. Fetching All Students**

1. **Request**:
   ```http
   GET /students HTTP/1.1
   Host: your-spring-boot-server-url
   ```

2. **Response**:
   ```http
   HTTP/1.1 200 OK
   Content-Type: application/json

   [
     {
       "id": "123",
       "name": "John Doe",
       "email": "john.doe@example.com",
       ...
     }
   ]
   ```

### **5.2. Adding a New Student**

1. **Request**:
   ```http
   POST /students HTTP/1.1
   Host: your-spring-boot-server-url
   Content-Type: application/json

   {
     "id": "123",
     "name": "John Doe",
     "email": "john.doe@example.com",
     ...
   }
   ```

2. **Response**:
   ```http
   HTTP/1.1 201 Created
   ```

---

## **6. Conclusion**

This API documentation provides a comprehensive guide to the endpoints used by the Flutter frontend to interact with the Spring Boot backend. By following this guide, developers can ensure seamless communication between the frontend and backend.

