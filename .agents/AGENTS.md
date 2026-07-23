# AGENTS.md — AI Agent Guidelines & Coding Standards for Shalaverse

> **Instructions and architectural rules for AI Coding Assistants working on the Shalaverse codebase.**

---

## 1. Project Context & Stack Overview

* **App Name**: Shalaverse 🎓
* **Framework**: Flutter (SDK `^3.11.0`) & Dart
* **Architecture**: Clean Architecture with Feature-first directory structure under `lib/src/features/` or `lib/features/`.
* **State Management**: BLoC pattern (`package:flutter_bloc`) with immutable state classes (`package:equatable` / sealed classes).
* **Routing**: Declarative Routing with `package:go_router`.
* **Flavors**: `dev`, `uat`, `stage`, `prod` (managed via `AppConfig` and native flavor flags).

---

## 2. Core Architectural & Code Conventions

### 2.1 Feature Directory Layout
Organize code by feature module:
```
lib/src/features/<feature_name>/
├── domain/
│   ├── models/            # Entity definitions & value objects
│   └── repositories/      # Abstract repository interfaces
├── data/
│   ├── datasources/       # Remote (REST/GraphQL) & Local datasources
│   ├── models/            # DTOs & JSON serialization
│   └── repositories/      # Concrete repository implementations
└── presentation/
    ├── bloc/              # Events, States, & BLoCs
    ├── screens/           # Main screen UI widgets
    └── widgets/           # Reusable feature-specific UI sub-widgets
```

---

## 3. Strict Business Logic Guardrails for AI Agents

When implementing features or refactoring code in Shalaverse, you **MUST** strictly adhere to the following domain rules derived from [REQUIREMENTS.md](file:///Users/rathish/Documents/Work/shalaverse/REQUIREMENTS.md):

### 3.1 Role-Based Access Control (RBAC) Guardrails
* **Parent Role Restrictions**:
  * Parents must NEVER be presented with a "Join Class" or "Start Class" button in any screen or BLoC.
  * Attempting to navigate a Parent account to a Google Meet session route must throw an unauthorized navigation error or be blocked by a GoRouter redirect guard.
* **Student Role Restrictions**:
  * Students cannot initiate or start classes.
  * Students' "Join Class" button MUST be conditionally disabled (`enabled = false`) whenever `classStatus != ClassStatus.started`.
  * Display a clear *"Waiting for teacher to start class"* UI banner while `classStatus == ClassStatus.scheduled`.

### 3.2 Domain State Machine Models
Always use strongly-typed enums for status representations:

```dart
/// Represents the lifecycle state of a scheduled class
enum ClassStatus {
  scheduled,
  started,
  completed,
  cancelled,
  missed,
}

/// Represents student attendance confirmed by teacher
enum AttendanceStatus {
  present,
  absent,
  late,
  excused,
}

/// Represents parent remark & general query status
enum TicketStatus {
  newTicket,
  inReview,
  resolved,
  closed,
}
```

### 3.3 Notification & Timing Logic
* **15-Minute Reminder**: Notification payload trigger logic must evaluate `class.scheduledStartTime.difference(DateTime.now()).inMinutes == 15`.
* **5-Minute Delay Trigger**: Delay monitor timer must fire if `DateTime.now().isAfter(class.scheduledStartTime.add(const Duration(minutes: 5)))` and `class.status == ClassStatus.scheduled`.

---

## 4. Code Quality & Lint Standards

* **Static Analysis**: Run `flutter analyze` after modifying Dart files and resolve all lints.
* **Format**: All code must conform to standard Dart formatting (`dart format .`).
* **Preserve Documentation**: Preserve all existing docstrings and comments.
* **No Symptom Masking**: Never wrap missing properties in empty `try-catch` blocks or quiet defaults without root-cause justification.

---

## 5. Testing Requirements

* **BLoC Unit Tests**: Provide `bloc_test` suites for state transitions in every BLoC implementation under `test/features/<feature_name>/bloc/`.
* **Widget Tests**: Provide widget tests (`WidgetTester`) for role-based conditional rendering (e.g., verifying join button activation states).
