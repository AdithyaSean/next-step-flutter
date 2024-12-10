# Setup Guide

## Prerequisites
1. Java Development Kit (JDK) 17+
2. Flutter SDK (latest stable)
3. Android Studio / VS Code
4. Git

## Backend Setup

### 1. Spring Boot Setup
```bash
# Clone repository
git clone https://github.com/yourusername/Next-Step.git
cd Next-Step/backend

# Build project using Maven
./mvnw clean install
```

### 2. Database Setup
```bash
# Local development uses SQLite
# The database file will be created automatically
# Location: backend/data/nextstep.db

# Production PostgreSQL (if needed)
# Configure in application.properties
spring.datasource.url=jdbc:postgresql://localhost:5432/nextstep
spring.datasource.username=your_username
spring.datasource.password=your_password
```

### 3. ML Model Setup
```bash
# DJL models are stored in
backend/src/main/resources/models/

# No additional setup required
# Models are loaded automatically at startup
```

## Frontend Setup

### 1. Flutter Setup
```bash
cd frontend

# Get dependencies
flutter pub get

# Run the app
flutter run
```

### 2. Local Database
```bash
# SQLite is handled by sqflite package
# Database is created automatically on first run
# Location: [App Directory]/nextstep.db
```

## Development Environment

### IDE Configuration
1. VS Code
   ```json
   {
     "java.configuration.updateBuildConfiguration": "automatic",
     "spring-boot.ls.java.home": "[Path to JDK]",
     "dart.lineLength": 80,
     "editor.formatOnSave": true
   }
   ```

2. Android Studio
   - Enable "Format code on save"
   - Set Dart line length to 80
   - Enable "Organize imports on save"

### Environment Variables
```properties
# Backend (application.properties)
spring.profiles.active=dev
server.port=8080
app.ml.model.path=classpath:models/career_predictor.onnx

# Frontend (.env)
API_BASE_URL=http://localhost:8080
```

## Running Tests

### Backend Tests
```bash
# Run all tests
./mvnw test

# Run specific test class
./mvnw test -Dtest=StudentProfileServiceTest
```

### Frontend Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/student_profile_test.dart
```

## Common Issues

### Backend
1. Port conflicts
   ```properties
   # Change in application.properties
   server.port=8081
   ```

2. Database errors
   ```bash
   # Reset local database
   rm backend/data/nextstep.db
   ```

### Frontend
1. Flutter version mismatch
   ```bash
   flutter upgrade
   flutter pub get
   ```

2. Build errors
   ```bash
   flutter clean
   flutter pub get
   ```
