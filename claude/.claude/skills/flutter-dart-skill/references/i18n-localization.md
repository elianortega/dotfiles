# Localization

## Overview

Flutter provides built-in support for internationalization (i18n) and localization (l10n) through the `flutter_localizations` package and ARB files.

## Setup

### pubspec.yaml

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any

flutter:
  generate: true
```

### l10n.yaml

```yaml
arb-dir: lib/l10n/arb
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

## ARB Files

Application Resource Bundle (ARB) files contain translations:

**`app_en.arb`:**

```json
{
  "@@locale": "en",
  "welcomeMessage": "Welcome, {name}!",
  "@welcomeMessage": {
    "description": "Welcome message with user name",
    "placeholders": {
      "name": {
        "type": "String",
        "example": "John"
      }
    }
  },
  "itemCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}",
  "@itemCount": {
    "description": "Number of items",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

## Usage in Widgets

```dart
Text(AppLocalizations.of(context).welcomeMessage('John'))
```

Or with a context extension:

```dart
Text(context.l10n.welcomeMessage('John'))
```

## Best Practices

- Use ARB files for all user-facing strings
- Never hardcode user-facing text
- Use descriptive key names
- Include `@` metadata for translator context
- Support pluralization using ICU message format
- Test with multiple locales
- Generate localizations with `flutter gen-l10n`
