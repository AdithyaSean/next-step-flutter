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
python3 -m pip install --upgrade setuptools wheel

# Install all requirements
echo "📥 Installing project dependencies..."
python3 -m pip install --upgrade -r requirements.txt

# Install package in development mode
echo "🛠️ Installing package in development mode..."
python3 -m pip install -e .

# Create necessary directories
echo "🗂️ Creating project directories..."
mkdir -p src/data/{raw,processed,generators,preprocessors}
mkdir -p src/models/{train,server}
mkdir -p logs

# Set up pre-commit hooks if git is initialized
if [ -d ".git" ]; then
    echo "🔩 Setting up pre-commit hooks..."
    pre-commit install
fi

echo "✨ Setup complete! Activate the virtual environment with:"
echo "   source venv/bin/activate"
