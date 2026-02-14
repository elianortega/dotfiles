# BLoC Event Transformers

## Overview

Since Bloc v7.2.0, events are handled concurrently by default, allowing event handler instances to execute simultaneously without guarantees regarding completion order. While concurrent handling offers benefits, it can introduce performance issues and serious data defects if your event transformer doesn't align with your state management needs.

Race conditions can produce bugs when the result of operations varies with their order of execution.

## Registering Event Transformers

Event transformers are specified in the `transformer` field of event registration functions within the Bloc constructor:

```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(MyState()) {
    on<MyEvent>(
      _onEvent,
      transformer: mySequentialTransformer(),
    );
    on<MySecondEvent>(
      _onSecondEvent,
      transformer: mySequentialTransformer(),
    );
  }
}
```

Each `on<E>` statement creates a bucket for handling events of type `E`. Event transformers apply only within their specified bucket.

## Transformer Types

The `bloc_concurrency` package provides several ready-made transformers:

- `concurrent` (default)
- `sequential`
- `droppable`
- `restartable`

### Sequential

Processes events one at a time in first-in-first-out order:

```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(MyState()) {
    on<MyEvent>(
      _onEvent,
      transformer: sequential(),
    );
  }
}
```

**When to use:** When operations must not overlap. Example: financial transactions where concurrent reads/writes cause data loss.

```dart
class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  MoneyBloc() : super(MoneyState()) {
    on<ChangeBalance>(_onChangeBalance, transformer: concurrent());
  }

  Future<void> _onChangeBalance(
    ChangeBalance event,
    Emitter<MoneyState> emit,
  ) async {
    final balance = await api.readBalance();
    await api.setBalance(balance + event.add);
  }
}
```

With concurrent handling and two events `ChangeBalance(add: 20)` and `ChangeBalance(add: 40)`:

1. First handler reads balance of $100, sends request to update to $120
2. Second handler executes before the first completes, reads $100, updates to $140
3. First handler's update request arrives, overwriting balance to $120

Sequential processing prevents such issues.

### Droppable

Discards events added while another event in that bucket is processing:

```dart
class SayHiBloc extends Bloc<SayHiEvent, SayHiState> {
  SayHiBloc() : super(SayHiState()) {
    on<SayHello>(
      _onSayHello,
      transformer: droppable(),
    );
  }

  Future<void> _onSayHello(
    SayHello event,
    Emitter<SayHiState> emit,
  ) async {
    await api.say("Hello!");
  }
}
```

**When to use:** Preventing API clogging from duplicate requests (e.g., button spam). Note that data stored in dropped events will be lost.

### Restartable

Halts previous handler execution to process the most recent event:

```dart
class ThoughtBloc extends Bloc<ThoughtEvent, ThoughtState> {
  ThoughtBloc() : super(ThoughtState()) {
    on<ThoughtEvent>(
      _onThought,
      transformer: restartable(),
    );
  }

  Future<void> _onThought(
    ThoughtEvent event,
    Emitter<ThoughtState> emit,
  ) async {
    await api.record(event.thought);
    emit(
      state.copyWith(
        message: 'This is my most recent thought: ${event.thought}',
      ),
    );
  }
}
```

**When to use:** When only the latest event matters (e.g., search-as-you-type).

## Testing BLoCs with Transformers

Variable event handling order can cause unpredictable test behavior with `blocTest`. Use `await Future<void>.delayed(Duration.zero)` to ensure task queue completion before adding events:

**Good:**

```dart
blocTest<MyBloc, MyState>(
  'change value',
  build: () => MyBloc(),
  act: (bloc) async {
    bloc.add(ChangeValue(add: 1));
    await Future<void>.delayed(Duration.zero);
    bloc.add(ChangeValue(remove: 1));
  },
  expect: () => const [
    MyState(value: 1),
    MyState(value: 0),
  ],
);
```

**Bad:**

```dart
blocTest<MyBloc, MyState>(
  'change value',
  build: () => MyBloc(),
  act: (bloc) {
    bloc.add(ChangeValue(add: 1));
    bloc.add(ChangeValue(remove: 1));
  },
  expect: () => const [
    MyState(value: 1),
    MyState(value: 0),
  ],
);
```
