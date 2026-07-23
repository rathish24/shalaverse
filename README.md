# Shalaverse 🎓✨

**Shalaverse** is a cross-platform educational institution management application built with [Flutter](https://flutter.dev/). It streamlines class scheduling, virtual learning via Google Meet, automated attendance, delay notifications, and parent engagement across schools, coaching centers, and academies.

---

## 📚 Documentation & Specifications

* 📋 **[Product Requirements Document (PRD)](REQUIREMENTS.md)**: Full functional specifications, user role matrix (Admin, Teacher, Student, Parent), class lifecycle state machine, 15-min reminders, 5-min delay alert logic, attendance confirmation, and query resolution pipeline.
* 🤖 **[AI Agent Rules & Guidelines](.agents/AGENTS.md)**: Coding standards, Clean Architecture guidelines, state machine enums, and RBAC code enforcement rules for AI assistants working in this repository.

---

## 🚀 Features & Overview

- **Cross-Platform**: Designed to run seamlessly across Android, iOS, Web, macOS, Windows, and Linux.
- **Role-Based Workflows**: Tailored interfaces for Administrators, Teachers, Students, and Parents.
- **Google Meet Integration**: Synchronized virtual classrooms with teacher-managed session initiation.
- **Automated Punctuality & Tracking**: Automated 15-minute class reminders and 5-minute non-start delay alerts.
- **Attendance Engine**: Auto-tracked teacher start time and post-class manual student attendance (`Present`, `Absent`, `Late`, `Excused`).
- **Parent Remarks & Queries**: Contextual remark submission for completed classes and general support query tracking.

---

## 🛠️ Tech Stack & Requirements

- **Framework**: [Flutter](https://flutter.dev/) (SDK `^3.11.0`)
- **Language**: [Dart](https://dart.dev/)
- **UI Framework**: Material Design 3
- **State Management**: BLoC Pattern (`package:flutter_bloc`)
- **Routing**: `go_router`

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

Run project unit and widget tests:
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
├── .agents/          # AI agent skills & project rules (AGENTS.md)
├── android/          # Android native project configuration & code
├── ios/              # iOS native project configuration & code
├── lib/              # Main Dart application source code
│   └── main.dart     # Entry point of the application
├── macos/            # macOS desktop platform code
├── web/              # Web platform assets & configuration
├── windows/          # Windows desktop platform code
├── linux/            # Linux desktop platform code
├── REQUIREMENTS.md   # Product Requirement Document & Functional Specs
├── pubspec.yaml      # Project dependencies & assets configuration
└── README.md         # Developer landing page & setup guide
```

---

## 🤝 Contributing & License

Private repository. All rights reserved.
