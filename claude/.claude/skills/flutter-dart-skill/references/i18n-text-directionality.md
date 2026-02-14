# Text Directionality

## Overview

Supporting variable text directions is critical for internationalization. While many languages (English) are left-to-right (LTR), many others (Arabic, Hebrew, Farsi) are right-to-left (RTL).

## How Flutter Handles Directionality

The `Directionality` widget forms the foundation. Its `textDirection` property controls direction for all children.

A default global `Directionality` is determined by the user's locale.

```dart
// Get current directionality
Directionality.of(context)

// Explicitly set directionality
Directionality(
  textDirection: textDirectionLTR ? TextDirection.ltr : TextDirection.rtl,
  child: Row(
    children: [
      // children order flips with directionality
    ],
  ),
)
```

Flutter uses the Unicode Bidirectional Algorithm to determine the visual representation order of text.

## Visual vs Directional Widgets

Flutter offers both visually- and directionally-demarcated widget variants:

- **Visual**: Absolute directions (`top`, `left`, `right`, `bottom`)
- **Directional**: Relative to text alignment (`top`, `start`, `end`, `bottom`)

### EdgeInsets vs EdgeInsetsDirectional

```dart
// Directional - padding always at start of text regardless of direction
Padding(
  padding: EdgeInsetsDirectional.only(start: 12),
  child: Text('Padding at start regardless of LTR/RTL'),
)

// Visual - padding always on the left
Padding(
  padding: EdgeInsets.only(left: 10),
  child: Text('Padding always to the left'),
)
```

Many widgets have `Directional` variants: `Positioned`/`PositionedDirectional`, `Border`/`BorderDirectional`, etc.

## Non-Text Elements

### Icons

Icons are mirrored by default when text direction flips. To keep an icon static:

```dart
Icon(
  Icons.arrow_forward,
  textDirection: TextDirection.ltr, // Forces LTR regardless of locale
)
```

### Images

Use `matchTextDirection: true` to mirror images in RTL:

```dart
Image.asset(
  'assets/arrow.png',
  matchTextDirection: true, // Mirrors in RTL
)
```

## Mirroring Standards

Follow bidirectional design conventions:

- **Mirror**: Visual references to direction or future time (arrows)
- **Do not mirror**: Media progress indicators, playback controls
- **Do not mirror**: Physical objects, brand logos

Consult Material Design's Bidirectionality guide for comprehensive rules.
