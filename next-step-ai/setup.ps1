# PowerShell setup script for Next Step AI

# Error handling
$ErrorActionPreference = "Stop"

Write-Host "🚀 Setting up Next Step AI development environment..."

# Check Python version
$python_version = (python -V 2>&1).ToString().Split(" ")[1]
Write-Host "📌 Using Python version: $python_version"

# Version check
$version_parts = $python_version.Split(".")
$major = [int]$version_parts[0]
$minor = [int]$version_parts[1]

if ($major -lt 3 -or ($major -eq 3 -and $minor -lt 12)) {
    Write-Host "❌ Error: Python 3.12 or higher is required"
    Write-Host "Current version: $python_version"
    exit 1
}

# Create virtual environment if it doesn't exist
if (-not (Test-Path "venv")) {
    Write-Host "🔧 Creating virtual environment..."
    python -m venv venv
}

# Activate virtual environment
Write-Host "🔌 Activating virtual environment..."
.\venv\Scripts\Activate.ps1

# Upgrade pip
Write-Host "⬆️ Upgrading pip..."
python -m pip install --upgrade pip

# Install dependencies
Write-Host "📦 Installing dependencies..."
pip install -r requirements.txt

# Create necessary directories
Write-Host "📁 Creating necessary directories..."
$directories = @("data", "logs", "models")
foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir
        Write-Host "Created directory: $dir"
    }
}

Write-Host "✅ Setup completed successfully!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Activate the virtual environment:"
Write-Host "   .\venv\Scripts\Activate.ps1"
Write-Host "2. Train the models:"
Write-Host "   python -m src.models.train"