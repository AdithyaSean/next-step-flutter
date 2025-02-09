# Users Microservice Documentation

## Overview
The Users Microservice handles user management, authentication, and student profile operations in the Next Step platform.

## API Endpoints

### Authentication
- `POST /login`
  - Authenticates users and returns a UUID
  - Headers: None
  - Body: 
    ```json
    {
      "username": "string",
      "password": "string"
    }
    ```
  - Response:
    ```json
    {
      "id": "UUID",
      "username": "string",
      "name": "string",
      "email": "string",
      "role": "STUDENT"
    }
    ```

### Student Management
- `POST /students`
  - Creates a new student account
  - Headers: None
  - Body:
    ```json
    {
      "username": "string",
      "name": "string",
      "email": "string",
      "password": "string",
      "telephone": "string",
      "school": "string",
      "district": "string"
    }
    ```
  - Response: `201 Created` with UserDTO

- `GET /students/profile`
  - Retrieves student profile
  - Headers: `UUID: student-uuid`
  - Response: `200 OK` with StudentProfileDTO

- `PUT /students/profile`
  - Updates student profile
  - Headers: `UUID: student-uuid`
  - Body: StudentProfileDTO
  - Response: `200 OK` with updated StudentProfileDTO

## Data Models

### UserDTO
Base DTO for all users
```java
{
    UUID id;
    String username;     // @NotBlank
    String name;        // @NotBlank
    String email;       // @NotBlank @Email
    String password;    // @NotBlank
    String telephone;   // @NotBlank
    UserRole role;      // @NotNull
    boolean active;
    LocalDateTime createdAt;
    LocalDateTime updatedAt;
}
```

### StudentDTO
Extends UserDTO with student-specific fields
```java
{
    String school;      // @NotBlank
    String district;    // @NotBlank
    StudentProfileDTO studentProfile;
}
```

### StudentProfileDTO
Contains student's academic information
```java
{
    UUID id;
    int educationLevel;
    Map<String, Double> olResults;
    Integer alStream;
    Map<String, Double> alResults;
    Map<String, Double> careerProbabilities;
    Double gpa;
    LocalDateTime createdAt;
    LocalDateTime updatedAt;
}
```

## Implementation Details

### Key Components

1. Controllers
   - `AuthController`: Handles login/authentication
   - `StudentController`: Manages student registration and profile operations
   - `UserController`: Generic user operations
   - `InstitutionController`: Institution-related operations

2. Services
   - `AuthService`: Authentication logic
   - `StudentService`: Student business logic
   - `UserService`: Generic user operations
   - `InstitutionService`: Institution-related operations

3. Repositories
   - `UserRepository`: Data access for all user types

### Student Profile Flow
1. User registers as a student (`POST /students`)
2. User logs in (`POST /login`)
3. Frontend receives UUID
4. Frontend uses UUID to:
   - Fetch profile (`GET /students/profile`)
   - Update profile (`PUT /students/profile`)

### Notes
- All endpoints return appropriate HTTP status codes
- Validation constraints ensure data integrity
- UUID is used for user identification across the system
- Profile operations require valid UUID in headers
