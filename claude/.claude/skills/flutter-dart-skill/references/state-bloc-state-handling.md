# BLoC State Handling

## Overview

Two primary approaches for managing state in Flutter's Cubit/Bloc pattern: using enums with a single state class, or using sealed/abstract classes for isolated state types.

## Key Decision Point

The fundamental question: do you need to **preserve previous data across state emissions** or **emit completely fresh states**?

## Approach 1: Single Class with Enum Status (Persist Data)

When building forms or features where data updates incrementally (like filling out account information step-by-step), use a single class with an enum as the state's "status" to maintain previously entered information.

```dart
enum CreateAccountStatus { initial, loading, success, failure }

class CreateAccountState extends Equatable {
  const CreateAccountState({
    this.status = CreateAccountStatus.initial,
    this.name = '',
    this.email = '',
    this.password = '',
  });

  final CreateAccountStatus status;
  final String name;
  final String email;
  final String password;

  bool get isValid => name.isNotEmpty && email.isNotEmpty && password.isNotEmpty;

  CreateAccountState copyWith({
    CreateAccountStatus? status,
    String? name,
    String? email,
    String? password,
  }) {
    return CreateAccountState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, name, email, password];
}
```

Each state emission updates specific fields while retaining others through `copyWith()`.

## Approach 2: Sealed Classes (Fresh States)

For scenarios where you fetch independent data without needing historical information, use sealed classes to isolate each state variant.

```dart
sealed class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  ProfileSuccess(this.profile);
  final Profile profile;
}

class ProfileFailure extends ProfileState {
  ProfileFailure(this.errorMessage);
  final String errorMessage;
}
```

### Consumption with Pattern Matching

```dart
BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return switch (state) {
      ProfileLoading() => const CircularProgressIndicator(),
      ProfileSuccess(:final profile) => Text(profile.name),
      ProfileFailure(:final errorMessage) => Text(errorMessage),
    };
  },
)
```

## Abstract Classes (Older Flutter Versions)

For Flutter versions before 3.13, abstract classes provide similar behavior:

```dart
abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  ProfileSuccess(this.profile);
  final Profile profile;
}

class ProfileFailure extends ProfileState {
  ProfileFailure(this.errorMessage);
  final String errorMessage;
}
```

Consumption requires explicit type checking instead of pattern matching.

## Shared Properties Across States

Both approaches support sharing properties by placing them in parent classes:

```dart
sealed class ProfileState {
  const ProfileState({this.lastUpdated});
  final DateTime? lastUpdated;
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({super.lastUpdated});
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess(this.profile, {super.lastUpdated});
  final Profile profile;
}
```

Pattern matching can catch multiple states containing a property simultaneously using `||` syntax.

## When to Use Which

| Scenario | Approach |
|----------|----------|
| Forms with incremental data | Single class + enum |
| Step-by-step wizards | Single class + enum |
| Data fetching (load/success/failure) | Sealed classes |
| Independent state transitions | Sealed classes |
| Need previous data in new state | Single class + enum |
