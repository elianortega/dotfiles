# Golden File Testing

## Overview

Golden file tests capture a snapshot of a widget's rendered appearance and compare future renders against it. They detect unintended visual changes.

## How It Works

1. First run generates a golden file (PNG image) of the widget
2. Subsequent runs render the widget and compare pixel-by-pixel against the golden file
3. If differences are detected, the test fails

## Setting Up Golden Tests

### Basic Golden Test

```dart
testWidgets(
  'renders correctly',
  tags: TestTag.golden,
  (WidgetTester tester) async {
    await tester.pumpApp(const MyWidget());

    await expectLater(
      find.byType(MyWidget),
      matchesGoldenFile('goldens/my_widget.png'),
    );
  },
);
```

### Using Tags

Tag golden tests so they can be run separately:

```dart
abstract class TestTag {
  static const golden = 'golden';
}
```

Configure tags in `dart_test.yaml`:

```yaml
tags:
  golden:
    description: "Golden file tests"
```

### Running Golden Tests

```bash
# Run only golden tests
flutter test --tags golden

# Update golden files
flutter test --tags golden --update-goldens
```

## Best Practices

- Store golden files in a `goldens/` directory alongside tests
- Use descriptive file names that match the widget being tested
- Run golden tests separately from unit tests using tags
- Update golden files intentionally when UI changes are expected
- Review golden file diffs carefully in pull requests

## When to Use

- Testing complex UI layouts
- Verifying theme consistency
- Catching unintended visual regressions
- Documenting expected widget appearance
