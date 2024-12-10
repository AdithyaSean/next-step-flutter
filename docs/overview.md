# Next Step - System Overview 🎓

## System Architecture

Next Step is built with a two-tier architecture:

### 1. AI Model Component (`/next-step-ai/`)

The AI component is responsible for:
- Processing student data and generating features
- Training recommendation models
- Exporting models in ONNX format for mobile deployment
- Evaluating model performance

Key Technologies:
- Python 3.12+
- LightGBM for model training
- ONNX for model export
- Scikit-learn for preprocessing

### 2. Mobile App Component (`/next-step-flutter/`)

The Flutter app provides:
- User interface for data collection
- Model inference using ONNX runtime
- Results visualization
- Educational pathway explanations

Key Technologies:
- Flutter SDK
- ONNX Runtime Mobile
- Material Design 3

## Data Flow

1. **Data Collection**
   - User inputs personal information
   - Academic performance data
   - Interest and preference data

2. **Processing**
   - Feature engineering
   - Data normalization
   - Model inference

3. **Recommendation Generation**
   - Stream recommendations
   - University field predictions
   - Confidence scores

4. **Results Presentation**
   - Visual representation of recommendations
   - Explanation of factors
   - Alternative pathways

## Performance Metrics

Current model performance:
- Stream Recommendation: 86.00% accuracy
- University Field Recommendation: 21.05% accuracy

## Development Workflow

1. **AI Model Development**
   ```bash
   cd next-step-ai
   ./setup.sh  # or setup.ps1 on Windows
   python -m src.models.train
   ```

2. **Mobile App Development**
   ```bash
   cd next-step-flutter
   flutter pub get
   flutter run
   ```

## Deployment

The system is designed for:
- Local model training
- Mobile-first deployment
- Offline inference capability

For more detailed information, see:
- [API Documentation](api.md)
- [Mobile Integration Guide](mobile.md)
- [Model Training Guide](training.md)
