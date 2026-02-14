# Layered Architecture

## Overview

Client applications follow a three-layer architecture with clear separation of concerns:

1. **Presentation Layer** - UI widgets and pages
2. **Business Logic Layer** - BLoCs/Cubits managing state
3. **Data Layer** - Repositories and data providers

## Architecture Diagram

```
┌─────────────────────────┐
│    Presentation Layer    │  Widgets, Pages, Views
├─────────────────────────┤
│   Business Logic Layer   │  BLoCs, Cubits
├─────────────────────────┤
│       Data Layer         │  Repositories, Data Providers
└─────────────────────────┘
```

## Presentation Layer

The presentation layer is responsible for rendering the UI based on the state from the business logic layer. It should contain no business logic.

### Page/View Pattern

Each screen consists of two classes:

- **Page**: Defines the route and gathers dependencies from context
- **View**: Contains the actual UI implementation

```dart
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authenticationRepository =
            context.read<AuthenticationRepository>();
        return LoginBloc(
          authenticationRepository: authenticationRepository,
        );
      },
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  @visibleForTesting
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // UI implementation
  }
}
```

The `LoginView` constructor is marked `@visibleForTesting` to ensure the view is only used via its page, preventing accidental imports without injected dependencies.

## Business Logic Layer

BLoCs and Cubits manage the application state. They receive events, process business logic, and emit new states.

- BLoCs depend on repositories (never on other BLoCs)
- Each BLoC handles a specific feature or domain
- Events describe user actions or system events
- States represent the UI state at any point in time

## Data Layer

### Repositories

Repositories abstract data sources and provide a clean API to the business logic layer.

- Repositories can depend on data providers (never on BLoCs)
- They transform raw data into domain models
- They handle caching and data synchronization
- They expose streams for reactive data updates

### Data Providers

Data providers handle direct communication with external services (APIs, databases, etc.).

## Feature Structure

A feature follows this folder structure:

```
my_feature/
├── bloc/
│   ├── feature_bloc.dart
│   ├── feature_event.dart
│   └── feature_state.dart
├── view/
│   ├── feature_page.dart
│   ├── feature_view.dart
│   └── view.dart
├── widgets/
│   ├── widget_1.dart
│   ├── widget_2.dart
│   └── widgets.dart
└── my_feature.dart
```

## Benefits

- **Reduced cognitive load**: Each layer has focused responsibilities
- **Improved readability**: Clear boundaries make code easier to follow
- **Individual testability**: Each layer can be tested in isolation
- **Team scalability**: Developers can work on different layers independently
