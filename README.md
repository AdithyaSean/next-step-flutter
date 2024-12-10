# Next Step 🎓

An AI-powered educational pathway recommendation system that helps students make informed decisions about their academic and career paths.

## 🌟 Features

- **Stream Recommendation**: Get personalized recommendations for academic streams based on your interests and performance
- **University Field Prediction**: Discover potential university fields that align with your goals
- **Interactive Mobile App**: User-friendly Flutter interface for easy access to recommendations
- **AI-Powered Insights**: Advanced machine learning models for accurate predictions

## 🏗️ Project Structure

The project is divided into two main components:

1. **AI Model** (`/next-step-ai/`)
   - Machine learning models for educational pathway recommendations
   - Data preprocessing and feature engineering
   - Model training and evaluation pipeline

2. **Mobile App** (root directory)
   - Flutter-based mobile application
   - User interface for input collection
   - Results visualization and explanation

## 🚀 Getting Started

### Prerequisites
- Python 3.12+ (for AI model)
- Flutter SDK (for mobile app)
- Git

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/Next-Step.git
   cd Next-Step
   ```

2. Run the setup script for the AI Model:
   ```bash
   cd next-step-ai
   ./setup.sh  # For Linux/macOS
   # OR
   .\setup.ps1  # For Windows
   ```

3. Set up the Flutter App:
   ```bash
   flutter pub get
   ```

### Running Components Separately

#### AI Model
```bash
cd next-step-ai
source venv/bin/activate  # Activate Python virtual environment
python -m src.models.train  # Train the model
```

#### Flutter App
```bash
flutter run  # Run the Flutter app
```

## 📊 Current Performance

- Stream Recommendation: 86.00% accuracy
- University Field Recommendation: 21.05% accuracy (under improvement)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

[Your License]
