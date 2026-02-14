# Code Documentation

## Public API Documentation

Enforce documentation of all public widgets and APIs using the `public_member_api_docs` lint rule. Include clear descriptions, required vs optional parameters, and usage constraints.

## Use Asserts Over Inline Comments

Dart asserts with messages enforce conditions during development and provide immediate feedback when violations occur. Unlike comments, assertions actively prevent errors.

**Good:**

```dart
assert(
  a != 0,
  'The coefficient of the square term must not be zero, '
  'otherwise is not a quadratic equation.',
);
```

**Bad:**

```dart
// The coefficient of the square term must not be zero
// otherwise is not a quadratic equation.
```

## DartDoc Comments

Use `///` for documentation comments:

```dart
/// A calculator that performs basic arithmetic operations.
///
/// Example:
/// ```dart
/// final calculator = Calculator();
/// final result = calculator.add(2, 3); // 5
/// ```
class Calculator {
  /// Adds two numbers and returns the result.
  ///
  /// Throws [ArgumentError] if either number is negative.
  int add(int a, int b) => a + b;
}
```

## What to Document

- All public APIs (classes, methods, properties)
- Complex algorithms or business logic
- Non-obvious design decisions
- Workarounds or known limitations

## What Not to Document

- Self-explanatory code
- Implementation details that change frequently
- Obvious getter/setter behavior
