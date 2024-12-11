# NEXT STEP: Career Guidance AI Model

## Overview
This repository contains the AI model component for the Next Step career guidance application. The model uses a LightGBM for multi-label classification to predict suitable career paths based on student academic performance and interests.

## Features
- **Multi-label Career Path Prediction:** Predicts multiple suitable career paths simultaneously
- **Comprehensive Feature Engineering:** Handles various academic inputs (O/L results, A/L results, interests)
- **Education Level Awareness:** Adapts predictions based on student's current education level
- **Binary Career Path Encoding:** Efficient encoding of career paths for multi-label classification
- **Robust Data Preprocessing:** Handles missing values and categorical variables appropriately

## Technical Stack
- **Python 3.12+**
- **scikit-learn:** LightGBM for multi-label classification
- **pandas & numpy:** Data processing and numerical operations
- **joblib:** Model serialization

## Model Architecture
- **Type:** LightGBM Classifier with MultiOutputClassifier
- **Features:** 49 input features including:
  - O/L results (mathematics, science, english, etc.)
  - A/L results (if applicable)
  - Stream information
  - Z-score (if applicable)
  - Interests (encoded as binary features)
  - Other academic indicators
- **Output:** 5 binary indicators for different career paths

## Current Performance
Based on synthetic data:
- Average Accuracy: >99% across all career paths
- Precision & Recall: >0.94 for all classes
- F1-Score: >0.94 for all classes

Note: These metrics are based on synthetic data and may not reflect real-world performance.

## 🚀 Getting Started

### Prerequisites
- Python 3.12 or higher
- Virtual environment (recommended)

### Setup
1. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Linux/macOS
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

### Training the Model
```bash
# Navigate to the AI model directory
cd next-step-ai

# One time setup
./setup.sh # for Linux/macOS
.\setup.ps1 # for Windows

# Activate the virtual environment
source venv/bin/activate  # On Linux/macOS
venv\Scripts\activate # On Windows

# Generate synthetic dataset
python -m src.data.generators

# Preprocess the data
python -m src.data.preprocess

# Train the model
python -m src.models.train
```

## 📁 Project Structure
```
next-step-ai/
├── data/
│   ├── generators/     # Synthetic data generation
│   ├── processed/      # Preprocessed datasets
│   └── raw/           # Raw datasets
├── models/
│   ├── saved/         # Trained model files
│   └── train.py       # Model training script
└── src/
    ├── data/          # Data processing modules
    └── models/        # Model definition and training
```

## Integration with Spring Boot
The trained model can be accessed from Spring Boot through:
1. Loading the saved model using joblib
2. Converting input data to match the model's feature format
3. Making predictions using the loaded model

Example Spring Boot integration:
```java
@Service
public class PredictionService {
    private Python python;
    private PyObject model;

    @PostConstruct
    public void init() {
        // Initialize Python interpreter
        python = Python.getInstance();
        // Load the saved model
        model = python.getModule("joblib").load("path/to/model.joblib");
    }

    public List<String> predictCareerPaths(StudentData student) {
        // Convert student data to feature array
        // Make prediction using the model
        // Convert prediction back to career path labels
    }
}
```

## 🔧 Development
- Format code: `black .`
- Run tests: `pytest`
- Generate new synthetic data: `python -m src.data.generators`

## 📊 Future Improvements
1. Collect real student data for training
2. Implement cross-validation for better evaluation
3. Experiment with different model architectures
4. Add confidence scores for predictions
5. Implement model versioning and monitoring

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request
