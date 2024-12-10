#!/bin/bash

# Exit on error
set -e

echo "🚀 Setting up Next Step AI development environment..."

# Check Python version
python_version=$(python3 -V 2>&1 | awk '{print $2}')
echo "📌 Using Python version: $python_version"

# Remove existing venv if it exists
if [ -d "venv" ]; then
    echo "🧹 Removing existing virtual environment..."
    rm -rf venv
fi

# Create virtual environment
echo "📦 Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "🔌 Activating virtual environment..."
source venv/bin/activate

# Upgrade pip and install build dependencies first
echo "🔄 Upgrading pip and installing build dependencies..."
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade setuptools wheel

# Install all requirements
echo "📥 Installing project dependencies..."
python3 -m pip install --upgrade -r requirements.txt

# Create necessary directories
echo "🗂️ Creating project directories..."
mkdir -p src/data/{raw,processed}
mkdir -p src/models/output
mkdir -p logs

# Set up pre-commit hooks if git is initialized
if [ -d ".git" ]; then
    echo "🔩 Setting up pre-commit hooks..."
    # Add any pre-commit setup here
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file..."
    cp .env.example .env || echo "⚠️  No .env.example found, skipping..."
fi

# Verify installation
echo "🔍 Verifying key packages..."
python3 -c "import sys; print(f'Python: {sys.version}')"
python3 -c "import numpy; print(f'NumPy: {numpy.__version__}')"
python3 -c "import pandas; print(f'Pandas: {pandas.__version__}')"
python3 -c "import sklearn; print(f'Scikit-learn: {sklearn.__version__}')"
python3 -c "import lightgbm; print(f'LightGBM: {lightgbm.__version__}')"
python3 -c "import onnx; print(f'ONNX: {onnx.__version__}')"
python3 -c "import onnxruntime; print(f'ONNX Runtime: {onnxruntime.__version__}')"
python3 -c "import onnxmltools; print(f'ONNX ML Tools: {onnxmltools.__version__}')"

echo "✅ Setup complete! To get started:"
echo "1. Activate the virtual environment:"
echo "   source venv/bin/activate"
echo "2. Train the models:"
echo "   python3 src/models/train.py"
