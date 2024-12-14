# Next Step - System Overview 🎓

## System Architecture

Next Step uses a modular monolith architecture with three main components:

### 1. AI Model Component (`/next-step-ai/`)

The AI component is responsible for:
- Processing student data and generating features
- Training recommendation models using advanced algorithms
- Exporting models in Joblib format for mobile deployment
- Performance monitoring and model evaluation
- Generating realistic training data

Key Technologies:
- Python 3.12+
- PostgreSQL 14+
- LightGBM model
- Dart ORM
- WebSocket

### 2. AI Component (`/next-step-ai/`)
Integrated within the central server:
- Monitors database changes for prediction triggers
- Updates predictions in real-time
- Stores results back to PostgreSQL
- Performance monitoring

### 3. Mobile App Component (`/next-step-flutter/`)

The Flutter app provides:
- Educational pathway exploration
- External resource browser
- Profile management
- Offline predictions
- Real-time updates

Key Technologies:
- Flutter SDK
- SQLite for local storage
- BLoC pattern
- Material Design 3
- External link handling

## System Features

### 1. Prediction System
- Multi-label career path predictions
- Education level-aware predictions
- Feature engineering pipeline
- Binary career path encoding
- Confidence scoring

### 2. Educational Exploration
- Stream requirements and prospects
- Course details and prerequisites
- Institution links
- Career pathway suggestions

### 3. Career Guidance
- Multiple career path suggestions
- Educational requirements
- Institution websites
- Additional resource links

### 4. Data Management
- Offline-first architecture
- Real-time synchronization
- Data validation
- Link management

## Architecture Benefits

1. **Comprehensive Predictions**
   - Multiple career paths
   - Education level awareness
   - Feature engineering
   - Binary encoding
   - Confidence scoring

2. **Efficient Processing**
   - Random Forest efficiency
   - Binary classification
   - Fast predictions
   - Lightweight model

3. **Robust Integration**
   - REST API access
   - Spring Boot integration
   - Flutter compatibility
   - Real-time updates

## Development Workflow

1. **AI Model Development**
   ```bash
   cd next-step-ai
   ./setup.sh  # or setup.ps1 on Windows
   python -m src.models.train
   python -m src.data.generators.dataset_generator  # for synthetic data
   ```

2. **Backend Development**
   ```bash
   cd next-step-backend
   ./gradlew bootRun
   ```

3. **Mobile App Development**
   ```bash
   cd next-step-flutter
   flutter pub get
   flutter run
   ```

## Key Features

1. **ORM Integration**
   - JPA/Hibernate for object-relational mapping
   - Type-safe entities and relationships
   - Automatic schema generation
   - Transaction management

2. **Offline-First Architecture**
   - Local storage with SQLite
   - Background sync service
   - Conflict resolution
   - Delta updates

3. **Real-Time Updates**
   - WebSocket integration
   - Push notifications
   - Live data synchronization
   - Event-driven updates

4. **Security**
   - JWT authentication
   - Role-based access control
   - Secure data storage
   - API protection

5. **Modularity**
   - Clear separation of concerns
   - Independent deployability
   - Shared domain model
   - Easy testing

For more detailed information, see:
- [Data Model](data-model.md)
- [Development Roadmap](roadmap.md)

1
