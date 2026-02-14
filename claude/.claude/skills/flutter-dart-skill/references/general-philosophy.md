# Philosophy

## Our Philosophy

Very Good Ventures consolidated popular coding practices into "Very Good Architecture." The approach enables teams to "ship fast and ship safe," delivering quality software on time consistently.

A good software architecture requires these qualities:

- **Consistent**: strong opinions on complex problems like state management
- **Flexible**: easy feature refactoring or replacement
- **Approachable**: rapid onboarding for junior developers
- **Testable**: automated testing with high code coverage
- **Performant**: quick execution by default
- **Multiplatform**: single app across all platforms

## Building for Success

The majority of software projects fail due to controllable and uncontrollable factors. Engineering improvements directly increase positive business outcomes. Complex software requires making each individual step "as easy as possible" -- addressing the problem incrementally.

## Layered Architecture

Client applications follow a three-layer architecture: presentation, business logic, and data. Clear architectural boundaries reduce knowledge requirements per layer, improve readability, lower cognitive load for maintenance, and enable individual unit testing.

## Keep It Simple -- for the Humans

As AI continues to improve at code generation, it is becoming increasingly important to create well-organized code that we -- the humans -- can understand, verify, and maintain.

The goal is creating "the least amount of readable code to perform the work by modeling the problem space correctly." Three seemingly opposing constraints bind this definition: minimal code, readability, and correctness.

Recommended approaches:

- Declarative code wherever possible
- Thoughtful naming
- Object-oriented design patterns
- Tests

## Declarative Programming

Declarative programming means declaring what presentation or business logic should be. The contrast:

**Declarative:**

```dart
return Visualizer(
  children: [
    VisualElement(),
  ],
);
```

**Imperative:**

```dart
final visualizer = Visualizer();
final text = VisualElement();
visualizer.add(text);
return visualizer;
```

Most code quality-of-life improvements result from making code more declarative because business logic reasoning is simpler than combining it with implementation details.

## Reactive Programming

Reactive programming manipulates data streams and falls under declarative programming through data transformation descriptions. Reactive code is introduced cautiously, typically only at the repository layer to broadcast data changes.

```dart
void main() {
  final stream = Stream<int>.fromIterable([1, 2, 3, 4, 5]);
  final mappedStream = stream.map((value) => value + 1);

  mappedStream.listen((value) {
    print(value);
  });
}
```

Complex data transformations are known for being difficult to grasp. Reactive tools can accidentally introduce component coupling. "Reactive programming is like glue -- it's extremely strong, but it's sticky and it gets everywhere if you're not careful."

## Consistency

Strong opinions exist regarding tests, dependency injection, state management, and business logic organization. Consistency reduces learning curves and enables faster developer onboarding.

## Flexibility

Layered architecture allows rapid response to changing product requirements while maintaining high code quality and refactorability. Similar patterns between features enable efficient developer contribution.

## Approachability

State management approaches require boilerplate, but "additional rigor allows us to easily understand what's going on, making it easy to refactor quickly."

## Performance

Technologies compiling to machine code are prioritized. Algorithmic time complexity receives consideration to avoid nested loops and expensive transformations. Third-party library selection draws from extensive client experience across dozens of projects.

Flutter is recommended for most multiplatform projects: it's performant, developer-friendly, and fully open source, ensuring "it is resilient to changes in the industry and supported well into the future."

## Multiplatform

"It's easier to maintain one high-quality codebase than it is to maintain two -- especially if exact feature parity and precise deadlines are a priority."

Google's Flutter framework enables one app running on iOS, Android, Web, Linux, macOS, and Windows. Written in Dart (a modern language in the Java/C# family), over 45,000 packages exist on pub.dev. Flutter provides hot reload, extensive widgets, and native platform plugins.
