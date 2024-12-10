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
- RESTful APIs for data synchronization
- WebSocket support for real-time updates
- JWT-based authentication
- Conflict resolution for offline-first sync

Key Technologies:
- Spring Boot 3.x
- WebSocket
- JWT Authentication
- SQLite/PostgreSQL

### 3. Mobile App Component (`/next-step-flutter/`)

The Flutter app provides:
- Offline-first architecture with Hive
- BLoC pattern for state management
- Bi-directional sync with backend
- Elegant Material Design 3 UI
- Background sync capabilities

Key Technologies:
- Flutter SDK
- Hive for local storage
- BLoC for state management
- ONNX Runtime Mobile
- Material Design 3

## Data Flow

1. **Data Collection & Sync**
   - User inputs stored locally in Hive
   - Background sync with backend
   - Conflict resolution for offline changes

2. **Processing**
   - Feature engineering
   - Data normalization
   - Model inference
   - Real-time updates via WebSocket

3. **Recommendation Generation**
   - Stream recommendations with confidence scores
   - University field predictions
   - Alternative pathway suggestions

4. **Results Presentation**
   - Interactive visualization of recommendations
   - Detailed factor analysis
   - Alternative pathways with probabilities

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

## Deployment

The system supports:
- Local model training
- Mobile-first deployment
- Offline-first capabilities
- Real-time sync when online
- Background processing

For more detailed information, see:
- [Data Model](data-model.md)
- [Education Schema](education-schema.md)
- [Development Roadmap](roadmap.md)
