# Next-Step API Documentation

## Core Endpoints

### Authentication

All authenticated endpoints require a UUID header:
```
UUID: student-uuid
```

### Users

1. **Register Student**
   - `POST /students`
   - Request:
     ```json
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
     ```
   - Response (201 Created):
     ```json
     {
       "id": "550e8400-e29b-41d4-a716-446655440000",
       "username": "student1",
       "name": "John Student",
       "email": "student1@example.com",
       "role": "STUDENT",
       "active": true,
       "createdAt": "2024-02-09T13:30:00Z",
       "updatedAt": "2024-02-09T13:30:00Z"
     }
     ```

2. **Login**
   - `POST /login`
   - Request:
     ```json
     {
       "username": "student1",
       "password": "pass123"
     }
     ```
   - Response (200 OK):
     ```json
     {
       "id": "550e8400-e29b-41d4-a716-446655440000",
       "username": "student1",
       "name": "John Student",
       "email": "student1@example.com",
       "role": "STUDENT",
       "active": true
     }
     ```

3. **Get Student Profile**
   - `GET /students/profile`
   - Headers: `UUID: student-uuid`
   - Response (200 OK):
     ```json
     {
       "id": "550e8400-e29b-41d4-a716-446655440000",
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
       },
       "careerProbabilities": {
         "Engineering": 85.3,
         "Medicine": 72.1,
         "IT": 68.5
       },
       "createdAt": "2024-02-09T13:30:00Z",
       "updatedAt": "2024-02-09T13:30:00Z"
     }
     ```

4. **Update Student Profile**
   - `PUT /students/profile`
   - Headers: `UUID: student-uuid`
   - Request Body: StudentProfileDTO (see examples below)
   - Response (200 OK): Updated StudentProfileDTO

### Profile Examples

See [User Management Service Documentation](users-microservice/summary.md) for complete StudentDTO details and [Recommendations Service Documentation](recommendations-microservice/summary.md) for academic data requirements.

### Error Responses
All endpoints return standard HTTP status codes with error details:
```json
{
  "status": 400,
  "error": "Bad Request",
  "message": "Invalid input data"
}
```

Common error codes:
- 400: Bad Request (invalid input)
- 401: Unauthorized (missing/invalid UUID)
- 404: Not Found (user/profile not found)
- 500: Server Error
