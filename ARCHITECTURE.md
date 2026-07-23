# Architecture Guidelines — Shalaverse 🎓

> **Vertical Slice Architecture & Project Organization Standards**

---

## 1. Core Architectural Overview

Shalaverse follows **Vertical Slice Architecture** paired with **Feature-First Clean Architecture** principles:
* **Feature Co-location**: All UI screens, widgets, BLoCs, repositories, and models for a domain feature live co-located inside a single feature folder under `lib/features/`.
* **Separation of Concerns**: Business logic (`package:flutter_bloc`) and data access are decoupled from UI presentation.
* **Core Encapsulation**: Non-domain infrastructure (networking, storage, themes, atomic design system widgets) lives inside `lib/core/`.

---

## 2. Directory Structure

### 2.1 Source Code (`lib/`)

```
lib/
├── main.dart                          # App entry point
├── bootstrap.dart                     # Async initialization (Firebase, DI, HydratedBloc)
│
├── app/                               # Root App Config & Navigation
│   ├── app.dart                       # MaterialApp root widget
│   ├── app_router.dart                # GoRouter configuration & guards
│   ├── route_names.dart               # Navigation route path constants
│   └── app_observer.dart              # Global BlocObserver & logging
│
├── core/                              # App-Wide Shared Infrastructure ONLY
│   ├── constants/                     # API endpoints, app constants, storage keys
│   ├── network/                       # Dio/HTTP API client, interceptors, error handling
│   ├── storage/                       # SecureStorage, LocalStorage, CacheManager
│   ├── theme/                         # AppTheme, Colors, Typography, Spacing
│   ├── utils/                         # Date formatters, validators, extensions
│   └── widgets/                       # Atomic shared UI primitives (AppButton, AppTextField, etc.)
│
└── features/                          # Self-Contained Vertical Slices
    ├── auth/                          # Authentication (BLoC, Repos, Models, Screens, Widgets)
    ├── dashboard/                     # Admin / Role Dashboards
    ├── students/                      # Student Management & Rosters
    ├── teachers/                      # Teacher Management & Rosters
    ├── attendance/                    # Attendance Tracking & Confirmation
    ├── class_scheduling/              # Full Feature Directory Breakdown Example
    │   ├── class_schedule_bloc.dart   # BLoC State Management
    │   ├── schedule_repository.dart   # Data Orchestrator & API Integration
    │   ├── class_model.dart           # Domain Model & ClassStatus enum
    │   ├── schedule_screen.dart       # Main Schedule UI Screen
    │   ├── class_card.dart            # Schedule card component
    │   ├── class_filter.dart          # Schedule filter component
    │   ├── join_button.dart           # State-bound join button component
    │   └── delay_alert_banner.dart    # 5-minute delay alert UI banner
    ├── fees/                          # Fee Records & Payments
    ├── notifications/                 # Push Notifications & Reminders
    ├── profile/                       # User Profiles & Settings
    ├── settings/                      # App Preferences & Theme/Lang Selectors
    └── player/                        # Video / Google Meet Session Integration
```

### 2.2 Test Code (`test/`)

```
test/
├── app/
│   └── app_router_test.dart           # Navigation & Route Guard Tests
│
├── core/                              # Infrastructure Unit Tests
│   ├── network/
│   │   └── api_client_test.dart
│   └── utils/
│       └── validators_test.dart
│
└── features/                          # Feature Unit & Widget Tests (Mirrors lib/ 1-to-1)
    ├── auth/
    │   ├── auth_bloc_test.dart        # BLoC State Transition Tests
    │   └── auth_repository_test.dart  # Data Layer Tests
    └── player/
        ├── player_bloc_test.dart
        ├── player_repository_test.dart
        └── player_screen_widget_test.dart # Widget Interaction Tests
```

---

## 3. Key Design Principles & Rules

1. **Flat Feature Structure By Default**: Keep feature folders flat co-located by default. Only introduce internal sub-directories (`screens/`, `widgets/`) if a feature exceeds ~10 files.
2. **Strict Scoping**:
   * Features MUST NOT import widgets or models from other feature folders.
   * Cross-feature data flow MUST go through abstract repositories or global BLoCs registered in `get_it`.
3. **Role-Based Access Control (RBAC)**:
   * Navigation guards in `app_router.dart` enforce role isolation (e.g., Parent accounts are blocked from Google Meet routes).
4. **Mirror Test Organization**:
   * Unit and widget tests under `test/` mirror the `lib/` structure 1-to-1 (e.g., `test/features/class_scheduling/class_schedule_bloc_test.dart`).

---

## 4. State Management Standards (BLoC)

* **BLoC Pattern (`package:flutter_bloc`)**: All feature business logic must be managed using BLoCs or Cubits.
* **Immutable State Classes**: Use Dart 3 sealed classes or `package:equatable` for predictable state transitions.
* **Event-Driven UI**: UI screens emit events and react to state changes (`BlocBuilder`, `BlocListener`, `BlocConsumer`). UI widgets MUST NOT perform direct API calls or mutate state directly.

---

## 5. Data Flow & Error Handling

```
[UI Screen / Widget] ──(emits Event)──> [BLoC / Cubit]
                                              │
                                   (calls Repository)
                                              ▼
[API Client / DB] <──(returns Data/Error)── [Repository]
```

* **Repository Layer**: Acts as the single source of truth, converting API responses/exceptions into strongly-typed domain models or `Result<T>` instances.
* **Standard `Result<T>` Pattern**: All repository methods must return a Dart 3 `sealed class Result<T>` for compile-time exhaustive pattern matching in BLoCs:

```dart
// lib/core/network/result.dart
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends Result<T> {
  final Exception exception;
  final String? message;
  const Failure(this.exception, {this.message});
}
```

* **Exhaustive BLoC Pattern Matching**:
```dart
final result = await repository.fetchSchedule();
switch (result) {
  case Success(:final data):
    emit(ScheduleLoaded(classes: data));
  case Failure(:final exception, :final message):
    emit(ScheduleError(message ?? exception.toString()));
}
```

* **No Quiet Failures**: Catch exceptions at the repository level and return a `Failure(exception)`. Never return silent nulls or empty fallback arrays without log tracing.

---

## 6. Flavor & Environment Configuration

* **Supported Flavors**: `dev`, `uat`, `stage`, `prod`.
* **Initialization**: Managed via native build configurations and `bootstrap.dart`, initializing `AppConfig` with flavor-specific API base URLs, logging levels, and analytics keys prior to running `main()`.

