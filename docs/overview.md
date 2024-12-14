# Next Step - System Overview 🎓

## System Architecture

Next Step uses a client-server architecture with three main components:

### 1. Central Server (`/next-step-server/`)
Houses both the AI model and database:
- PostgreSQL database for all application data
- LightGBM model for real-time predictions
- RESTful APIs for Flutter client
- WebSocket for real-time updates

Key Technologies:
- Python 3.12+
- PostgreSQL 14+
- LightGBM model
- Object Relational Mapping
- WebSocket

### 2. AI Component (`/next-step-ai/`)
Integrated within the central server:
- Monitors database changes for prediction triggers
- Updates predictions in real-time
- Stores results back to PostgreSQL
- Performance monitoring

### 3. Mobile App Component (`/next-step-flutter/`)
Lightweight client application:
- Direct connection to central server
- Real-time data sync via WebSocket
- Material Design 3 UI
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
   - Flutter compatibility
   - Real-time updates

## Development Workflow

1. **Server Setup**
   ```bash
   cd next-step-server
   ./setup.sh  # Sets up PostgreSQL and AI model
   ./gradlew bootRun
   ```

2. **Mobile App Development**
   ```bash
   cd next-step-flutter
   flutter pub get
   flutter run
   ```

## Key Features

1. **Centralized Data Management**
   - PostgreSQL for robust data storage
   - Real-time model predictions
   - Automatic sync with client
   - WebSocket updates

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
