# Next Step 🎓

## 🏗️ Project Structure

This project is a student recommendation system consisting of a Spring Boot backend and a Flutter frontend.

- **`docs/`**: Contains the Spring Boot backend code, including controllers, services, models, and API documentation.
- **`lib/`**: Contains the Flutter frontend code, including UI screens, controllers, services, and models.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Git
- Java 17 or later
- Maven

### Setup

1.  Clone the repository:

    ```bash
    git clone https://github.com/adithyasean/next-step-flutter.git
    ```

2.  Set up the Flutter App:

    ```bash
    flutter pub get
    ```

### Running Components Separately

#### Flutter App

```bash
flutter run -d chrome --web-port 3000 # Run the Flutter app
```

#### Spring Boot Backend

1.  Navigate to the `docs` directory (the Spring Boot project).
2.  Build and run the application using Maven:

    ```bash
    mvn spring-boot:run
    ```

    The backend API will be available at `http://localhost:8080`.

### Authentication

The application uses a simplified authentication mechanism. The user's UUID is passed in the `UUID` header for each request. There are no tokens or session management.
