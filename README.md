# Next Step

A comprehensive educational pathway recommendation system combining AI-powered predictions with a modern Flutter mobile interface.

## Project Structure

This project consists of two main components:

1. **AI Model** (`/next-step-ai/`)
   - Machine learning model for educational pathway recommendations
   - Built with Python 3.12+
   - Uses LightGBM, ONNX, and other ML libraries

2. **Flutter App** (root directory)
   - Cross-platform application
   - Built with Flutter
   - Provides user interface for the recommendation system

## Quick Start

### Prerequisites

- Python 3.12 or higher
- Flutter (latest stable version)
- Git

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/Next-Step.git
   cd Next-Step
   ```

2. Run the setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   Choose which components you want to set up (AI Model, Mobile App, or both).

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

## Development

- AI Model development is contained within the `next-step-ai` directory
- Flutter app development is in the root directory
- Each component can be developed and tested independently
