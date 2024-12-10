# NEXT STEP: Career Guidance AI Model

## Overview
This repository is dedicated to exploring and identifying the best AI model and datasets for building a career guidance application. The final product will be a multiplatform application developed using Flutter for our Innovation and Entrepreneurship module and NIBM HND in Software Engineering's capstone project. The app aims to assist Sri Lankan students in making informed educational and career decisions.

## Objective
The primary goal of this project is to experiment with various AI models and datasets to determine the most effective solution for:

1. Predicting suitable academic and career paths based on a student's exam performance, academic progress, and interests.
2. Providing multiple recommendations tailored to a student's current academic level.
3. Ensuring the model can self-evolve by incorporating user-provided data.

## Features
- **Prediction Models:** Suggest educational streams or career paths for OL, AL, and campus-level students.
- **Dynamic Recommendations:** Generate personalized advice based on user input.
- **Dataset Exploration:** Leverage datasets that include academic performance, career outcomes, and interests.
- **AI Model Comparison:** Evaluate the effectiveness of different machine learning models (e.g., Decision Trees, Neural Networks, Gradient Boosted Models).

## Dataset Requirements
We aim to use datasets that include:
- Academic marks and progress across OLs, ALs, and Universities.
- Career outcomes (e.g., graduation status, job acquisition).
- Initial career paths and long-term trajectories.
- User interests and extracurricular achievements.

### Sources
- Publicly available datasets on education and employment.
- Synthetic datasets created for simulating Sri Lankan students' academic and career journeys.

## Development Plan
This exploratory project will proceed as follows:

1. **Dataset Collection:** Identify and preprocess datasets that match our requirements.
2. **Model Training:** Train various machine learning models to predict educational and career paths.
3. **Evaluation Metrics:** Use metrics like accuracy, precision, recall, and F1-score to evaluate model performance.
4. **Iteration:** Fine-tune models and preprocess data to improve performance.
5. **Integration Preparation:** Ensure the chosen model is ready for integration with the Flutter frontend.

## 🚀 Getting Started

### Prerequisites
- Python 3.12 or higher
- Virtual environment (recommended)

### Setup
1. Create and activate a virtual environment:
   ```bash
   # On Linux/macOS
   python -m venv venv
   source venv/bin/activate

   # On Windows
   python -m venv venv
   .\venv\Scripts\Activate.ps1
   ```

2. Run the setup script:
   ```bash
   # On Linux/macOS
   ./setup.sh

   # On Windows
   .\setup.ps1
   ```

### Training the Model
```bash
# Make sure your virtual environment is activated
python -m src.models.train
```

## 📁 Directory Structure
```
career-guidance-ai-model/
├── data/                 # Contains datasets and preprocessing scripts
├── models/               # Trained models and configuration files
├── notebooks/            # Jupyter notebooks for experiments
├── src/                  # Core source code for training and evaluation
├── tests/                # Unit tests for the project
├── logs/                 # Training logs
├── requirements.txt      # Python dependencies
└── README.md             # Project documentation
```

## ⚡ Performance
Current model performance metrics:
- Stream Recommendation: 86.00% accuracy
- University Field Recommendation: 21.05% accuracy (under improvement)

## 🔧 Development
- Keep the virtual environment in `.gitignore`
- Run tests: `pytest`
- Format code: `black .`
- Lint code: `flake8`

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📬 Contact

- GitHub: https://github.com/adithyasean
- Email: adithyasean@gmail.com
