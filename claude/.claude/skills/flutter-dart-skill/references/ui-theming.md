# Theming

## Overview

Flutter's theming system allows you to define a consistent visual style across your application. Use `ThemeData` to centralize colors, typography, component styles, and more.

## Setting Up a Theme

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  ),
  home: const MyApp(),
)
```

## Accessing Theme Data

```dart
final theme = Theme.of(context);
final colorScheme = theme.colorScheme;
final textTheme = theme.textTheme;
```

## Best Practices

### Use Theme Extensions for Custom Tokens

```dart
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.brandPrimary,
    required this.brandSecondary,
  });

  final Color brandPrimary;
  final Color brandSecondary;

  @override
  AppColors copyWith({Color? brandPrimary, Color? brandSecondary}) {
    return AppColors(
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandSecondary: brandSecondary ?? this.brandSecondary,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      brandSecondary: Color.lerp(brandSecondary, other.brandSecondary, t)!,
    );
  }
}
```

### Use Semantic Color Names

Refer to colors by purpose, not by value:

**Good:**

```dart
colorScheme.primary
colorScheme.onPrimary
colorScheme.error
```

**Bad:**

```dart
Colors.blue
Color(0xFF2196F3)
```

### Dark Theme Support

```dart
MaterialApp(
  theme: lightTheme,
  darkTheme: darkTheme,
  themeMode: ThemeMode.system,
)
```

### Centralize Theme Definitions

Keep all theme definitions in dedicated files rather than scattering style definitions across widgets:

```
lib/
├── theme/
│   ├── app_theme.dart
│   ├── app_colors.dart
│   └── app_text_styles.dart
```
