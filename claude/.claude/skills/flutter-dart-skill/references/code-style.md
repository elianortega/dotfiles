# Code Style

## Linting

Use `very_good_analysis` for consistent, opinionated lint rules:

```yaml
# analysis_options.yaml
include: package:very_good_analysis/analysis_options.yaml
```

## Naming Conventions

### Files

- Use `snake_case` for file names
- Name files after the primary class/type they contain

### Classes

- Use `PascalCase` for class names
- Suffix widgets with their type: `LoginPage`, `LoginView`, `LoginBloc`

### Variables and Functions

- Use `camelCase` for variables, functions, and parameters
- Use `_camelCase` for private members
- Prefix boolean variables with `is`, `has`, `should`, etc.

### Constants

- Use `camelCase` for constants (not `SCREAMING_SNAKE_CASE`)

```dart
const maxRetries = 3;  // Good
const MAX_RETRIES = 3; // Bad
```

## Code Organization

### Import Order

1. Dart SDK imports
2. Flutter SDK imports
3. Third-party package imports
4. Project imports
5. Relative imports

Each group separated by a blank line.

### Class Member Order

1. Static constants
2. Static fields
3. Final fields
4. Mutable fields
5. Constructors
6. Factory constructors
7. Getters/Setters
8. Public methods
9. Private methods
10. `build` method (for widgets)

## Formatting

- Use `dart format` for consistent formatting
- Maximum line length: 80 characters
- Use trailing commas for multi-line argument lists

```dart
// Good - trailing comma triggers multi-line formatting
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      'Hello World',
      style: Theme.of(context).textTheme.bodyMedium,
    ),
  );
}
```

## Effective Dart

Follow [Effective Dart](https://dart.dev/effective-dart) guidelines for idiomatic Dart code.
