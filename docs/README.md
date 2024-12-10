# Next Step - Career Guidance System

## Overview
Next Step is an offline-first mobile application designed to provide career guidance for Sri Lankan students based on their academic performance, skills, and interests. The system uses machine learning to analyze student profiles and provide personalized educational and career recommendations.

## Key Features
- Academic profile management (O/L, A/L, University)
- Stream-specific career recommendations
- University course matching
- Offline-first operation
- Skills assessment and tracking

## Technical Stack
- Frontend: Flutter/Dart
- Backend: Java (Spring Boot)
- Database: SQLite (local), PostgreSQL (main)
- ML: DJL (Deep Java Library)

## Development Environment
### Required Software
- JDK 17 or higher
- Flutter SDK (latest stable)
- Android Studio / VS Code
- Git

### IDE Setup
- VS Code Extensions:
  - Flutter & Dart
  - Spring Boot Extension Pack
  - Java Extension Pack
- Android Studio Plugins:
  - Flutter & Dart

## Documentation Structure
```
docs/
├── architecture/           # System design
│   ├── data-model.md      # Data structures
│   ├── education-schema.md # Education system
│   └── overview.md        # System overview
├── setup/                 # Setup guides
│   └── setup.md          # Installation
└── roadmap.md            # Development plan
```

## Getting Started
1. Check [setup/setup.md](setup/setup.md) for installation
2. Review [architecture/overview.md](architecture/overview.md)
3. Follow [roadmap.md](roadmap.md) for development

## Development Status
Currently in Phase 1: Core Backend Development
- Setting up Spring Boot infrastructure
- Implementing Sri Lankan education data models
- Preparing ML model integration with DJL

## Project Structure
```
Next-Step/
├── backend/               # Spring Boot application
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/    # Java backend code
│   │   │   └── resources/# Configuration & ML models
│   │   └── test/        # JUnit tests
│   └── pom.xml          # Maven dependencies
├── frontend/             # Flutter application
│   ├── lib/             # Dart source code
│   ├── test/            # Flutter tests
│   └── pubspec.yaml     # Flutter dependencies
└── docs/                # Documentation
