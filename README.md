# Next Step 🎓

An AI-powered educational pathway recommendation system that helps students make informed decisions about their academic and career paths.

## 🌟 Features

- **Stream Recommendation**:
Get personalized recommendations for academic streams based on your interests and performance

- **University Field Prediction**:
Discover potential university fields that align with your goals

- **Interactive Mobile App**:
User-friendly Flutter interface for easy access to recommendations

- **AI-Powered Insights**:
Advanced machine learning models for accurate predictions

## 🏗️ Project Structure



## 🚀 Getting Started

### Prerequisites
- Python 3.12+ (for AI model)
- Flutter SDK (for mobile app)
- Git

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/adithyasean/Next-Step.git
   ```

2. Set up the Flutter App:
   ```bash
   flutter pub get
   ```

### Firebase Setup

Here's a step-by-step guide to set up the Firebase Flutter project:

#### Prerequisites
1. Install Flutter SDK
2. Install Firebase CLI:
   ```bash
   curl -sL https://firebase.tools | bash
   ```
3. Add firebase to path if not: (for windows)
   ```cmd
   setx PATH "%PATH%;%APPDATA%\npm"
   ```
4. Add flutterfire to path if not: (for windows)
   ```cmd
   setx /M PATH "%PATH%;%USERPROFILE%\AppData\Local\Pub\Cache\bin"
   ```

#### One-time Setup Steps

1. **Login to Firebase:**
   ```bash
   firebase login
   ```

2. **Install FlutterFire CLI:**
   ```bash
   dart pub global activate flutterfire_cli
   ```

3. **Configure Firebase:**
   ```bash
   flutterfire configure
   ```

#### After Each Pull

1. **Update Dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run Build Runner:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Clean and Run:**
   ```bash
   flutter clean
   flutter run
   ```

#### Troubleshooting

- If build fails:
  ```bash
  flutter clean
  flutter pub get
  flutter run
  ```

#### Important Notes
- Don't commit Firebase configuration files
- Keep `firebase_options.dart` in version control
- Update `.gitignore` to exclude sensitive files

### Running Components Separately

#### Flutter App
```bash
flutter run  # Run the Flutter app
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

[Your License]
