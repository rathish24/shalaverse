# Shalaverse 🎓✨

**Shalaverse** is a cross-platform application built with [Flutter](https://flutter.dev/).

---

## 🚀 Features & Overview

- **Cross-Platform**: Designed to run seamlessly across Android, iOS, Web, macOS, Windows, and Linux.
- **Modern UI**: Powered by Material Design 3 and Flutter.
- **Scalable Architecture**: Structured for clean, modular development and easy extension.

---

## 🛠️ Tech Stack & Requirements

- **Framework**: [Flutter](https://flutter.dev/) (SDK `^3.11.0`)
- **Language**: [Dart](https://dart.dev/)
- **UI Framework**: Material Design 3

### Prerequisites

Ensure you have the Flutter environment set up on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.11.0 or higher)
- Android Studio / Xcode (for mobile emulation and builds)
- VS Code or Android Studio with Flutter & Dart plugins

---

## 📦 Getting Started

### 1. Clone the repository
```bash
git clone <repository-url>
cd shalaverse
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Run with Build Flavors (`dev`, `uat`, `stage`, `prod`)

All environments use the single entry point `lib/main.dart`:

#### Mobile / Native Platforms (iOS & Android)
```bash
# Development
flutter run --flavor dev

# UAT
flutter run --flavor uat

# Staging
flutter run --flavor stage

# Production
flutter run --flavor prod
```

#### Web (Google Chrome)
```bash
# Production
flutter run -d chrome --dart-define=APP_FLAVOR=prod

# Staging
flutter run -d chrome --dart-define=APP_FLAVOR=stage

# UAT
flutter run -d chrome --dart-define=APP_FLAVOR=uat

# Development (default)
flutter run -d chrome
```

### 4. Build Bundles by Flavor
```bash
# Android APKs
flutter build apk --flavor dev
flutter build apk --flavor uat
flutter build apk --flavor stage
flutter build apk --flavor prod

# Web Release
flutter build web --dart-define=APP_FLAVOR=prod --release
```

---

## 🧪 Testing & Quality Assurance

Run project tests:
```bash
flutter test
```

Analyze code quality and static lints:
```bash
flutter analyze
```

---

## 📁 Project Structure

```
shalaverse/
├── android/          # Android native project configuration & code
├── ios/              # iOS native project configuration & code
├── lib/              # Main Dart application source code
│   └── main.dart     # Entry point of the application
├── macos/            # macOS desktop platform code
├── web/              # Web platform assets & configuration
├── windows/          # Windows desktop platform code
├── linux/            # Linux desktop platform code
├── pubspec.yaml      # Project dependencies & assets configuration
└── README.md         # Project documentation
```

---

## 🤝 Contributing & License

Private repository. All rights reserved.
