# Barrel Files

## Overview

Barrel files are responsible for exporting other public-facing files that should be made available to the rest of the app. They prevent messy import sections and make refactoring easier.

## The Problem

Without barrel files, importing multiple files from a package or feature requires separate imports:

```dart
import 'package:my_package/lib/src/widgets/widget_1';
import 'package:my_package/lib/src/widgets/widget_2';
```

If file names change during a refactor, all import locations must be updated.

## Package Structure with Barrel Files

```
my_package/
├── lib/
│   ├── src/
│   │   ├── models/
│   │   │   ├── model_1.dart
│   │   │   ├── model_2.dart
│   │   │   └── models.dart          # barrel file
│   │   └── widgets/
│   │       ├── widget_1.dart
│   │       ├── widget_2.dart
│   │       └── widgets.dart          # barrel file
│   └── my_package.dart               # top-level barrel file
├── test/
│   └── ...
└── pubspec.yaml
```

## Feature Structure with Barrel Files

```
my_feature/
├── bloc/
│   ├── feature_bloc.dart
│   ├── feature_event.dart
│   └── feature_state.dart
├── view/
│   ├── feature_page.dart
│   ├── feature_view.dart
│   └── view.dart                     # barrel file
└── my_feature.dart                   # top-level barrel file
```

## Barrel File Contents

**`models.dart`:**

```dart
export 'model_1.dart';
export 'model_2.dart';
```

**`widgets.dart`:**

```dart
export 'widget_1.dart';
export 'widget_2.dart';
```

**`my_package.dart`:**

```dart
export 'src/models/models.dart';
export 'src/widgets/widgets.dart';
```

## Guidelines

- Create one barrel file per folder
- Have a top-level barrel file to export the package as a whole
- Only export files intended for public use -- if `model_1.dart` is an internal dependency of `model_2.dart`, do not export it

## BLoC and Barrel Files

BLoCs do not need a separate barrel file because `feature_bloc.dart` acts as one via `part of` directives. See the [bloc documentation](https://bloclibrary.dev) for details.

## Tip

The [Dart Export Index VSCode extension](https://github.com/orestesgaolin/dart-export-index) can automatically export all files in a folder.
