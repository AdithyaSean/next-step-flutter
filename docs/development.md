# Development Documentation for Flutter Frontend

This document provides an overview of the Flutter frontend codebase, focusing on the `student.dart`, `student_service.dart`, and `auth_controller.dart` files. It explains the structure, functionality, and how these components interact with the backend.

---

## **1. Overview**

The Flutter frontend is designed to interact with a Spring Boot backend, providing a user-friendly interface for managing student data, authentication, and career predictions. The key components are:

- **`student.dart`**: Defines the `Student` and `CareerPrediction` data models.
- **`student_service.dart`**: Handles HTTP requests to the backend for CRUD operations on student data.
- **`auth_controller.dart`**: Manages user authentication, including Google Sign-In and Firebase integration.

---

## **2. Data Models (`student.dart`)**

The `student.dart` file defines the data models used in the application:

### **`Student` Class**
- Represents a student entity with attributes such as `id`, `name`, `email`, `contact`, `school`, `district`, `password`, `olResults`, `alResults`, `stream`, `zScore`, `gpa`, `interests`, `skills`, `predictions`, `firebaseUid`, and `firebaseToken`.
- Includes methods for serialization (`toJson`) and deserialization (`fromJson`) to facilitate communication with the backend.

### **`CareerPrediction` Class**
- Represents a career prediction for a student, with attributes `careerPath`, `probability`, and `predictedAt`.
- Also includes serialization and deserialization methods.

### **Key Features**
- **Type Safety**: Uses `Map<String, double>` for `olResults` and `alResults` to match the backend.
- **Null Safety**: Provides default values for optional fields like `stream`, `zScore`, and `gpa`.
- **Serialization**: Converts objects to JSON for HTTP requests and vice versa.

---

## **3. Service Layer (`student_service.dart`)**

The `student_service.dart` file contains the `StudentService` class, which handles HTTP requests to the backend.

### **Key Methods**
1. **`getStudents()`**:
    - Fetches a list of all students from the backend.
    - Returns a `List<Student>`.

2. **`getStudentById(String id)`**:
    - Fetches a single student by their ID.
    - Returns a `Student` object.

3. **`addStudent(Student student)`**:
    - Sends a POST request to add a new student to the backend.

4. **`updateStudent(Student student)`**:
    - Sends a PUT request to update an existing student.

5. **`deleteStudent(String id)`**:
    - Sends a DELETE request to remove a student by their ID.

### **Error Handling**
- Throws exceptions if HTTP requests fail (e.g., non-200 status codes).

### **Configuration**
- The `baseUrl` is passed to the `StudentService` constructor, allowing flexibility in connecting to different backend environments.

---

## **4. Authentication Controller (`auth_controller.dart`)**

The `auth_controller.dart` file contains the `AuthController` class, which manages user authentication and profile management.

### **Key Features**
1. **Google Sign-In**:
    - Uses the `google_sign_in` package to authenticate users via Google.
    - Integrates with Firebase Authentication to handle user credentials.

2. **Firebase Integration**:
    - Uses the `firebase_auth` package to manage Firebase user sessions.
    - Stores Firebase UID and token in the `Student` model.

3. **Profile Management**:
    - Checks if a student's profile is complete using the `isProfileComplete` method.
    - Handles user creation and updates after sign-in.

### **Key Methods**
1. **`signUp()`**:
    - Creates a new `Student` object and sends it to the backend via `StudentService`.

2. **`signInWithGoogle()`**:
    - Handles the Google Sign-In flow, including Firebase credential creation.
    - Calls `_handleUserAfterSignIn` to manage post-sign-in logic.

3. **`_handleUserAfterSignIn(User? user)`**:
    - Fetches the student's data from the backend after successful sign-in.

4. **`isProfileComplete(String userId)`**:
    - Checks if a student's profile is complete by verifying required fields.

5. **`getCurrentUserId()`**:
    - Returns the current Firebase user ID.

---

## **5. Integration with Backend**

### **Backend Requirements**
- The backend must expose REST endpoints for:
    - Fetching all students (`GET /students`).
    - Fetching a single student by ID (`GET /students/{id}`).
    - Adding a new student (`POST /students`).
    - Updating a student (`PUT /students/{id}`).
    - Deleting a student (`DELETE /students/{id}`).

### **Configuration**
- Update the `baseUrl` in `StudentService` to point to your Spring Boot backend.
- Ensure the backend and frontend models are aligned (e.g., `olResults` and `alResults` use `Map<String, double>`).

---

## **6. Example Workflow**

### **Sign-Up Flow**
1. User provides details (name, email, contact, etc.).
2. `AuthController.signUp()` creates a `Student` object and sends it to the backend via `StudentService.addStudent()`.

### **Sign-In Flow**
1. User signs in with Google.
2. `AuthController.signInWithGoogle()` handles the authentication flow.
3. After successful sign-in, `_handleUserAfterSignIn()` fetches the student's data from the backend.

### **Profile Completion Check**
1. `AuthController.isProfileComplete()` checks if the student's profile is complete by verifying required fields.

---

## **7. Testing and Debugging**

### **Testing**
- Use mock HTTP clients to test `StudentService` methods.
- Test authentication flows using Firebase Emulator Suite.

### **Debugging**
- Add logging to key methods (e.g., `signInWithGoogle`, `_handleUserAfterSignIn`).
- Check HTTP response status codes and error messages.

---

## **8. Future Enhancements**

1. **Error Handling**:
    - Improve error messages for failed HTTP requests.
    - Add retry logic for transient errors.

2. **Caching**:
    - Implement local caching for student data to reduce backend load.

3. **UI Integration**:
    - Integrate the `AuthController` and `StudentService` with Flutter widgets for a seamless user experience.

---

## **9. Conclusion**

The Flutter frontend is designed to be modular, maintainable, and easily integrated with a Spring Boot backend. By following the structure and guidelines outlined in this document, developers can extend and enhance the application to meet evolving requirements.