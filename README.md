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
- Python 3.8 or higher
- pip (Python package installer)
- Git
- Bash (Git Bash on Windows)

### Quick Setup
```bash
# One-shot setup command (creates venv and installs dependencies)
./setup.sh
```

### Development Setup
- Always activate the virtual environment before working on the project
- Use `pip freeze > requirements.txt` to update dependencies
- Keep the virtual environment in `.gitignore`

### Usage
1. Preprocess the dataset:
   ```bash
   python preprocess_data.py
   ```
2. Train a model:
   ```bash
   python train_model.py --model [model_name]
   ```
3. Evaluate the model:
   ```bash
   python evaluate_model.py --model [model_name]
   ```
4. Generate predictions:
   ```bash
   python predict.py --input [input_file.json]
   ```

## Directory Structure
```
career-guidance-ai-model/
├── data/                 # Contains datasets and preprocessing scripts
├── models/               # Trained models and configuration files
├── notebooks/            # Jupyter notebooks for experiments
├── src/                  # Core source code for training and evaluation
├── tests/                # Unit tests for the project
├── requirements.txt      # Python dependencies
└── README.md             # Project documentation
```

## Roadmap
- **Phase 1:** Explore available datasets and preprocess them.
- **Phase 2:** Experiment with baseline models.
- **Phase 3:** Fine-tune the best-performing model.
- **Phase 4:** Prepare the model for integration into the Flutter application.

## ⚡ Performance



## 🛠️ Development



## 📖 Documentation

Comprehensive documentation is available in the `/docs` directory:

- [Architecture Guide](docs/architecture.md)
- [Mobile Deployment](docs/mobile.md)
- [Performance Optimization](docs/optimization.md)
- [API Reference](docs/api.md)

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
