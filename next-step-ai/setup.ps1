# PowerShell setup script for Next Step AI

Write-Host "🚀 Setting up Next Step AI development environment..."

# Error handling
$ErrorActionPreference = "Stop"

# Check Python version
$pythonVersion = (python -V 2>&1).ToString().Split(" ")[1]
Write-Host "📌 Using Python version: $pythonVersion"

# Remove existing venv if it exists
if (Test-Path "venv") {
    Write-Host "🧹 Removing existing virtual environment..."
    Remove-Item -Recurse -Force "venv"
}

# Create virtual environment
Write-Host "📦 Creating virtual environment..."
python -m venv venv

# Activate virtual environment
Write-Host "🔌 Activating virtual environment..."
.\venv\Scripts\Activate.ps1

# Upgrade pip and install build dependencies first
Write-Host "🔄 Upgrading pip and installing build dependencies..."
python -m pip install --upgrade pip
python -m pip install --upgrade setuptools wheel

# Install all requirements
Write-Host "📥 Installing project dependencies..."
python -m pip install --upgrade -r requirements.txt

# Create necessary directories
Write-Host "🗂️ Creating project directories..."
$directories = @(
    "data\raw",
    "data\processed",
    "data\models",
    "logs",
    "models\saved"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
    }
}

# Set up pre-commit hooks if git is initialized
if (Test-Path ".git") {
    Write-Host "🔩 Setting up pre-commit hooks..."
    # Add any pre-commit setup here
}

# Create .env file if it doesn't exist
if (-not (Test-Path ".env")) {
    Write-Host "📝 Creating .env file..."
    if (Test-Path ".env.example") {
        Copy-Item ".env.example" ".env"
    } else {
        Write-Host "⚠️  No .env.example found, skipping..."
    }
}

# Verify installation
Write-Host "🔍 Verifying key packages..."
python -c "import sys; print(f'Python: {sys.version}')"
python -c "import numpy; print(f'NumPy: {numpy.__version__}')"
python -c "import pandas; print(f'Pandas: {pandas.__version__}')"
python -c "import sklearn; print(f'Scikit-learn: {sklearn.__version__}')"
python -c "import lightgbm; print(f'LightGBM: {lightgbm.__version__}')"

Write-Host "`n✅ Setup complete! Activate the virtual environment with:"
Write-Host "   .\venv\Scripts\Activate.ps1" -ForegroundColor Green
