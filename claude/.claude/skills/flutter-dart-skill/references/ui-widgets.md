# Widgets

Widgets are the reusable building blocks of your app's user interface. Design them to be readable, maintainable, performant, and testable.

## Page/View Pattern

Each page should be composed of two classes:

- **Page**: Responsible for defining the route and gathering dependencies from context
- **View**: Where the actual UI implementation resides

This separation allows the `Page` to provide dependencies to the `View`, enabling mocking when testing.

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
    // omitted
  }
}
```

The `LoginView` constructor is marked `@visibleForTesting` to ensure the view is only used via its page.

### Testing Page/View

```dart
class _MockLoginBloc extends MockBloc<LoginBloc, LoginState>
    implements LoginBloc {}

void main() {
  group('LoginView', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = _MockLoginBloc();
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        BlocProvider<LoginBloc>.value(
          value: loginBloc,
          child: LoginView(),
        ),
      );

      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}
```

## Standalone Widgets Over Helper Methods

When a widget grows complex, create a new widget class instead of a helper method.

**Good:**

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyText('Hello World!');
  }
}

class MyText extends StatelessWidget {
  const MyText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
```

**Bad:**

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _getText('Hello World!');
  }

  Text _getText(String text) {
    return Text(text);
  }
}
```

## Why Create a New Widget?

- **Testability**: Test the widget in isolation without parent dependencies
- **Maintainability**: Smaller widgets are easier to maintain and have their own `BuildContext`
- **Reusability**: Compose larger widgets from smaller, reusable ones
- **Performance**: Helper methods cause unnecessary rebuilds of the entire parent widget. Encapsulated widgets only rebuild themselves when their state changes.
