# Error Handling

## Overview

Proper error handling ensures a robust user experience and makes debugging easier.

## Layered Error Handling

### Data Layer

Catch and transform external errors into domain-specific exceptions:

```dart
class UserRepository {
  Future<User> getUser(String id) async {
    try {
      final response = await apiClient.getUser(id);
      return User.fromJson(response);
    } on ApiException catch (e) {
      throw UserNotFoundException(e.message);
    } catch (e) {
      throw UserFetchException('Failed to fetch user: $e');
    }
  }
}
```

### Business Logic Layer

Handle domain exceptions in BLoCs and emit error states:

```dart
Future<void> _onUserRequested(
  UserRequested event,
  Emitter<UserState> emit,
) async {
  emit(state.copyWith(status: UserStatus.loading));
  try {
    final user = await userRepository.getUser(event.userId);
    emit(state.copyWith(status: UserStatus.success, user: user));
  } on UserNotFoundException {
    emit(state.copyWith(status: UserStatus.notFound));
  } on UserFetchException catch (e) {
    emit(state.copyWith(status: UserStatus.failure, error: e.message));
  }
}
```

### Presentation Layer

React to error states in the UI:

```dart
BlocListener<UserBloc, UserState>(
  listenWhen: (previous, current) => current.status == UserStatus.failure,
  listener: (context, state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.error ?? 'An error occurred')),
    );
  },
)
```

## Best Practices

- Define custom exception classes for each domain
- Catch specific exceptions rather than generic `Exception`
- Transform errors at layer boundaries
- Never swallow exceptions silently
- Log errors for debugging (use monitoring tools like Sentry)
- Show user-friendly error messages in the UI
- Use `Either` or `Result` types for expected failure paths when appropriate
