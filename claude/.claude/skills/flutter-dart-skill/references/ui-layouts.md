# Layouts

## Overview

Flutter provides a rich set of layout widgets for building responsive and adaptive UIs. Understanding layout constraints and how to compose widgets is fundamental to building quality Flutter applications.

## Layout Principles

- Flutter layouts are built by composing widgets in a tree structure
- Parent widgets impose constraints on child widgets
- Children determine their size within those constraints
- Parents position children based on the child's size

## Common Layout Widgets

### Single-Child Layout Widgets

- `Container`: Combines common painting, positioning, and sizing widgets
- `Padding`: Adds padding around a child
- `Center`: Centers a child within itself
- `SizedBox`: Constrains child to a specific size
- `Expanded`: Expands a child to fill available space in a `Flex` widget
- `Flexible`: Controls how a child flexes relative to siblings

### Multi-Child Layout Widgets

- `Column`: Arranges children vertically
- `Row`: Arranges children horizontally
- `Stack`: Overlaps children
- `Wrap`: Arranges children that flow to the next line when space runs out
- `ListView`: Scrollable list of children
- `GridView`: Scrollable grid of children

## Responsive Design

### LayoutBuilder

Use `LayoutBuilder` to build widgets based on parent constraints:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return const WideLayout();
    }
    return const NarrowLayout();
  },
)
```

### MediaQuery

Access device information for responsive decisions:

```dart
final screenWidth = MediaQuery.of(context).size.width;
final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
```

## Best Practices

- Use `const` constructors where possible for performance
- Prefer `SizedBox` over `Container` when only size constraints are needed
- Use `Expanded` and `Flexible` instead of fixed sizes for adaptive layouts
- Consider `SafeArea` to avoid system UI overlap
- Test layouts on multiple screen sizes
