---
name: flutter-setup-bloc
description: Define, structure, and consume BLoCs (Business Logic Components) using `package:bloc`, `package:flutter_bloc`, `package:equatable`, and `bloc_lint` best practices with Dart 3 sealed event/state classes, pattern matching, Clean Architecture use cases, and `bloc_test`.
metadata:
  model: models/gemini-3.6-flash
  last_modified: Wed, 22 Jul 2026 23:59:59 GMT
---

# Flutter BLoC Creation & Best Practices Guide

Use this skill when creating a new BLoC feature or refactoring existing state management.

## 1. Complete `bloc_lint` Rule Set (from `pub.dev/packages/bloc_lint`)

| Rule | Category | Description & Guideline |
|---|---|---|
| **`avoid_flutter_imports`** | Decoupling | Import `package:bloc/bloc.dart` in BLoCs, **NOT** `package:flutter/...` or `package:flutter_bloc/...`. BLoCs should be pure Dart to remain fully decoupled from UI frameworks and enable fast Dart-only unit testing. |
| **`avoid_public_bloc_methods`** | Event Safety | Do **NOT** declare public methods on `Bloc` classes. State changes must only occur in response to events dispatched via `add(Event)`. |
| **`avoid_public_fields`** | Immutability | Keep zero mutable or public fields on Bloc/Cubit instances. The `state` object must be the sole source of truth. |
| **`prefer_build_context_extensions`** | UI Consumption | Use `context.read<T>()`, `context.watch<T>()`, and `context.select<T, R>()` in widgets instead of `BlocProvider.of<T>(context)`. |
| **`avoid_build_context_extensions`** | UI Safety | Avoid `context.read<T>()` directly inside `Widget.build()` methods to prevent stale references; use `context.watch` or `BlocBuilder`. |
| **`prefer_file_naming_conventions`** | Project Structure | Adhere to standard file naming: `{feature}_bloc.dart`, `{feature}_event.dart`, `{feature}_state.dart`, or `{feature}_cubit.dart`. |
| **`prefer_bloc`** | Architecture | Prefer `Bloc` over `Cubit` when event concurrency control (`package:bloc_concurrency`), event tracing (`BlocObserver`), or stream transformations are required. |
| **`prefer_cubit`** | Architecture | Optional stylistic rule: Prefer `Cubit` over `Bloc` for simple features without event transformers or complex event logging to reduce event boilerplate. |
| **`prefer_void_public_cubit_methods`** | Cubit API | Public methods on `Cubit` classes should return `void` or `Future<void>`. |

---

## 2. Choosing Between BLoC and Cubit (`prefer_bloc` vs `prefer_cubit`)

- **Use `Bloc` when**:
  - You need event concurrency control (`droppable()`, `restartable()`, `sequential()`).
  - You need event tracing, audit logging, or undo/redo mechanisms via `BlocObserver`.
  - The feature handles complex asynchronous event streams.
- **Use `Cubit` when**:
  - The feature has simple synchronous/asynchronous state transitions without custom event transformations (e.g. theme switching, simple counters, basic forms).
  - Teams adopt the `prefer_cubit` rule to minimize boilerplate for simple UI states.

---

## 3. Generic Code Blueprints

### A. Events (`{feature}_event.dart`)
```dart
import 'package:equatable/equatable.dart';

sealed class {Feature}Event extends Equatable {
  const {Feature}Event();

  @override
  List<Object?> get props => [];
}

class {Feature}LoadRequested extends {Feature}Event {
  const {Feature}LoadRequested();
}

class {Feature}ItemSubmitted extends {Feature}Event {
  final {Entity} item;

  const {Feature}ItemSubmitted(this.item);

  @override
  List<Object?> get props => [item];
}
```

### B. States (`{feature}_state.dart`)
```dart
import 'package:equatable/equatable.dart';

sealed class {Feature}State extends Equatable {
  const {Feature}State();

  @override
  List<Object?> get props => [];
}

class {Feature}InitialState extends {Feature}State {
  const {Feature}InitialState();
}

class {Feature}LoadingState extends {Feature}State {
  const {Feature}LoadingState();
}

class {Feature}LoadedState extends {Feature}State {
  final List<{Entity}> items;
  final bool isSubmitting;
  final String? errorMessage;

  const {Feature}LoadedState({
    required this.items,
    this.isSubmitting = false,
    this.errorMessage,
  });

  {Feature}LoadedState copyWith({
    List<{Entity}>? items,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return {Feature}LoadedState(
      items: items ?? this.items,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [items, isSubmitting, errorMessage];
}

class {Feature}ErrorState extends {Feature}State {
  final String message;

  const {Feature}ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
```

### C. BLoC Class (`{feature}_bloc.dart`)
```dart
import 'package:bloc/bloc.dart'; // Pure Dart import according to avoid_flutter_imports rule
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:tutorial_management/core/errors/result.dart';

class {Feature}Bloc extends Bloc<{Feature}Event, {Feature}State> {
  final Get{Feature}UseCase get{Feature}UseCase;
  final Add{Feature}UseCase add{Feature}UseCase;

  {Feature}Bloc({
    required this.get{Feature}UseCase,
    required this.add{Feature}UseCase,
  }) : super(const {Feature}InitialState()) {
    on<{Feature}LoadRequested>(_onLoadRequested, transformer: restartable());
    on<{Feature}ItemSubmitted>(_onItemSubmitted, transformer: droppable());
  }

  Future<void> _onLoadRequested(
    {Feature}LoadRequested event,
    Emitter<{Feature}State> emit,
  ) async {
    emit(const {Feature}LoadingState());

    final result = await get{Feature}UseCase();

    switch (result) {
      case Success(value: final items):
        emit({Feature}LoadedState(items: items));
      case ErrorResult(error: final failure):
        emit({Feature}ErrorState(failure.message));
    }
  }

  Future<void> _onItemSubmitted(
    {Feature}ItemSubmitted event,
    Emitter<{Feature}State> emit,
  ) async {
    final currentState = state;
    if (currentState is {Feature}LoadedState) {
      emit(currentState.copyWith(isSubmitting: true, errorMessage: null));
    }

    final result = await add{Feature}UseCase(event.item);

    switch (result) {
      case Success():
        if (currentState is {Feature}LoadedState) {
          final updated = List<{Entity}>.from(currentState.items)..add(event.item);
          emit({Feature}LoadedState(items: updated, isSubmitting: false));
        } else {
          add(const {Feature}LoadRequested());
        }
      case ErrorResult(error: final failure):
        if (currentState is {Feature}LoadedState) {
          emit(currentState.copyWith(isSubmitting: false, errorMessage: failure.message));
        } else {
          emit({Feature}ErrorState(failure.message));
        }
    }
  }
}
```

---

## 4. UI Integration & DI

### Dependency Injection Registration
```dart
sl.registerFactory<{Feature}Bloc>(
  () => {Feature}Bloc(
    get{Feature}UseCase: sl(),
    add{Feature}UseCase: sl(),
  ),
);
```

### UI Presentation Layer (`BlocConsumer`)
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class {Feature}Screen extends StatelessWidget {
  const {Feature}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<{Feature}Bloc, {Feature}State>(
      listener: (context, state) {
        if (state is {Feature}LoadedState && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        return switch (state) {
          {Feature}InitialState() || {Feature}LoadingState() =>
            const Center(child: CircularProgressIndicator()),
          {Feature}ErrorState(message: final msg) =>
            Center(child: Text(msg)),
          {Feature}LoadedState(items: final items) =>
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ListTile(title: Text(items[index].name)),
            ),
        };
      },
    );
  }
}
```

---

## 5. Unit Test Template (`bloc_test`)

```dart
blocTest<{Feature}Bloc, {Feature}State>(
  'emits [{Feature}LoadingState, {Feature}LoadedState] when fetch succeeds',
  build: () {
    when(mockUseCase()).thenAnswer((_) async => const Success([]));
    return featureBloc;
  },
  act: (bloc) => bloc.add(const {Feature}LoadRequested()),
  expect: () => [
    const {Feature}LoadingState(),
    const {Feature}LoadedState(items: []),
  ],
);
```
