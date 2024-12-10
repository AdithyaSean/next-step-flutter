# Next Step - System Overview 🎓

## System Architecture

Next Step uses a modular monolith architecture with three main components:

### 1. AI Model Component (`/next-step-ai/`)

The AI component is responsible for:
- Processing student data and generating features
- Training recommendation models using advanced algorithms
- Exporting models in ONNX format for mobile deployment
- Performance monitoring and model evaluation
- Generating realistic training data

Key Technologies:
- Python 3.12+
- LightGBM for model training
- ONNX for model export
- Scikit-learn for preprocessing
- Custom data generators for synthetic data

### 2. Backend Component (`/next-step-backend/`)

The Spring Boot backend provides:
- JPA/Hibernate ORM for data persistence
- RESTful APIs for data synchronization
- WebSocket support for real-time updates
- JWT-based authentication
- Conflict resolution for offline-first sync

Key Technologies:
- Spring Boot 3.x
- Spring Data JPA
- WebSocket
- JWT Authentication
- SQLite for local development

### 3. Mobile App Component (`/next-step-flutter/`)

The Flutter app provides:
- Offline-first architecture with SQLite
- BLoC pattern for state management
- Bi-directional sync with backend
- Elegant Material Design 3 UI
- Background sync capabilities

Key Technologies:
- Flutter SDK
- SQLite for local storage
- BLoC for state management
- ONNX Runtime Mobile
- Material Design 3

## Data Flow

1. **Data Collection & Sync**
   - User inputs stored locally in SQLite
   - Background sync with backend
   - Conflict resolution for offline changes
   - ORM-managed persistence

2. **Processing**
   - Feature engineering
   - Data normalization
   - Model inference
   - Real-time updates via WebSocket

3. **Recommendation Generation**
   - Stream recommendations with confidence scores
   - University field predictions
   - Alternative pathway suggestions
   - JPA-based entity relationships

4. **Results Presentation**
   - Interactive visualization of recommendations
   - Detailed factor analysis
   - Alternative pathways with probabilities
   - Real-time updates through WebSocket

## Performance Metrics

Current model performance:
- Stream Recommendation: 92.00% accuracy
- Physical Science: 89.50% accuracy
- Commerce: 88.75% accuracy
- Biological Science: 87.20% accuracy
- Technology: 86.90% accuracy
- Arts: 85.30% accuracy

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
