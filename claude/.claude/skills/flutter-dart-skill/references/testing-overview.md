# Testing Overview

## Test Types

### Unit Tests

Test a single function, method, or class in isolation. Fast to run, no Flutter SDK dependency.

```dart
test('Counter increments', () {
  final counter = Counter();
  counter.increment();
  expect(counter.value, 1);
});
```

### Widget Tests

Test a single widget in isolation. Require the Flutter SDK test environment.

```dart
testWidgets('MyWidget renders correctly', (tester) async {
  await tester.pumpWidget(const MyWidget());
  expect(find.text('Hello'), findsOneWidget);
});
```

### Integration Tests

Test a complete app or large part of it. Run on a real device or emulator.

## Testing Layered Architecture

### Data Layer Tests

Test repositories and data providers:

- Mock HTTP clients and external services
- Verify data transformation
- Test error handling and edge cases

### Business Logic Layer Tests

Test BLoCs and Cubits using `blocTest`:

```dart
blocTest<CounterBloc, CounterState>(
  'emits [1] when CounterEvent.increment is added',
  build: () => CounterBloc(),
  act: (bloc) => bloc.add(CounterEvent.increment),
  expect: () => [const CounterState(count: 1)],
);
```

### Presentation Layer Tests

Test widgets with mocked BLoCs:

```dart
testWidgets('renders count', (tester) async {
  final counterBloc = _MockCounterBloc();
  when(() => counterBloc.state).thenReturn(const CounterState(count: 42));

  await tester.pumpApp(
    BlocProvider<CounterBloc>.value(
      value: counterBloc,
      child: const CounterView(),
    ),
  );

  expect(find.text('42'), findsOneWidget);
});
```

## Testing Patterns

- **Arrange-Act-Assert**: Set up preconditions, execute the action, verify the result
- **Private mocks per file**: Avoid cross-test interference
- **setUp for shared initialization**: Reset state before each test
- **Group by class and method**: Organize tests as natural sentences

## Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/my_test.dart

# Run with random ordering
flutter test --test-randomize-ordering-seed random
```
