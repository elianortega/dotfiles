# Testing Best Practices

## Name Tests Descriptively

Be verbose in test names for readability and maintainability.

**Good:**

```dart
testWidgets('renders $YourView', (tester) async {});
testWidgets('renders $YourView for $YourState', (tester) async {});
test('given an [input] is returning the [output] expected', () async {});
blocTest<YourBloc, RecipeGeneratorState>('emits $StateA if ...',);
```

**Bad:**

```dart
testWidgets('renders', (tester) async {});
test('works', () async {});
blocTest<YourBloc, RecipeGeneratorState>('emits',);
```

## Tests as Natural Sentences

Organize tests so they read as natural sentences when combined with group names:

**Good:**

```dart
group(ShoppingCart, () {
  group('addItem', () {
    test('increases item count', () {
      // ShoppingCart addItem increases item count
    });

    test('updates total price', () {
      // ShoppingCart addItem updates total price
    });
  });

  group('calculateTotal', () {
    test('returns sum of all item prices', () {
      // ShoppingCart calculateTotal returns sum of all item prices
    });

    test('returns zero when cart is empty', () {
      // ShoppingCart calculateTotal returns zero when cart is empty
    });
  });
});
```

**Bad:**

```dart
void main() {
  test('Validate calculateTotal returns total when cart is empty', () {});
  test('ShoppingCart addItem increases item count', () {});
  test('returns zero', () {});
}
```

## Use String Expressions with Types

Reference types using string expressions for easier renaming:

**Good:**

```dart
testWidgets('renders $YourView', (tester) async {});
```

**Bad:**

```dart
testWidgets('renders YourView', (tester) async {});
```

For groups that only contain a type, omit the string expression:

```dart
group(YourView, () {});  // Good
group('$YourView', () {});  // Bad
```

## Keep Test Setup Inside a Group

When tests are optimized into a single file, setup methods outside groups cause side effects:

**Good:**

```dart
void main() {
  group(UserRepository, () {
    late ApiClient apiClient;

    setUp(() {
      apiClient = _MockApiClient();
    });

    // Tests...
  });
}
```

**Bad:**

```dart
void main() {
  late ApiClient apiClient;

  setUp(() {
    apiClient = _MockApiClient();
  });

  group(UserRepository, () {
    // Tests...
  });
}
```

## Use Private Mocks

Create private mocks for each test file to avoid unintended shared behavior:

**Good:**

```dart
class _MockYourClass extends Mock implements YourClass {}
```

**Bad:**

```dart
class MockYourClass extends Mock implements YourClass {}
```

The analyzer warns about unused private mocks (but not public ones) if the `unused_element` diagnostic is not suppressed.

## Use Keys Carefully

Find widgets by type instead of keys for better maintainability:

**Good:**

```dart
expect(find.byType(HomePage), findsOneWidget);
```

**Bad:**

```dart
expect(find.byKey(Key('homePageKey')), findsOneWidget);
```

## Initialize Shared Mutable Objects Per Test

Avoid flaky tests from shared state:

**Good:**

```dart
group(_MySubject, () {
  late _MySubjectDependency myDependency;

  setUp(() {
    myDependency = _MySubjectDependency();
  });

  test('value starts at 0', () {
    final subject = _MySubject(myDependency);
    expect(subject.value, equals(0));
  });

  test('value can be increased', () {
    final subject = _MySubject(myDependency);
    subject.increase();
    expect(subject.value, equals(1));
  });
});
```

**Bad:**

```dart
group(_MySubject, () {
  final _MySubjectDependency myDependency = _MySubjectDependency();

  test('value starts at 0', () {
    final subject = _MySubject(myDependency);
    expect(subject.value, equals(0));
  });

  test('value can be increased', () {
    final subject = _MySubject(myDependency);
    subject.increase();
    expect(subject.value, equals(1));
  });
});
```

## Do Not Share State Between Tests

Tests relying on static members or shared state can produce inconsistent results depending on execution order.

## Use Random Test Ordering

Run tests in random order to expose hidden dependencies:

```bash
flutter test --test-randomize-ordering-seed random
dart test --test-randomize-ordering-seed random
very_good test --test-randomize-ordering-seed random
```

## Avoid Magic Strings for Tags

Use constants instead of string literals for test tags:

**Good:**

```dart
testWidgets(
  'render matches golden file',
  tags: TestTag.golden,
  (WidgetTester tester) async {},
);
```

**Bad:**

```dart
testWidgets(
  'render matches golden file',
  tags: 'golden',
  (WidgetTester tester) async {},
);
```

Define an abstract class for tags:

```dart
abstract class TestTag {
  static const golden = 'golden';
}
```
