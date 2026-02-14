---
name: flutter-dart-skill
description: Flutter and Dart clean architecture, coding practices, and development guidelines. Use this skill when writing, reviewing, or architecting Flutter/Dart applications.
license: MIT
metadata:
  author: elianortega
  version: "1.0.0"
  date: February 2026
  abstract: Comprehensive Flutter/Dart development guide covering layered architecture, state management with BLoC, testing best practices, UI patterns, code style, internationalization, security, and CI/CD. Each reference file contains detailed explanations, code examples, and good/bad practice comparisons.
---

Based on practices from [Very Good Ventures Engineering](https://engineering.verygood.ventures).

# Flutter & Dart Skill

Comprehensive development guide for Flutter/Dart applications covering architecture, state management, testing, UI patterns, code style, and more.

## When to Apply

Reference these guidelines when:
- Architecting a new Flutter application or feature
- Writing widgets, BLoCs, repositories, or data layers
- Reviewing Flutter/Dart code for quality and consistency
- Writing or improving tests (unit, widget, golden)
- Implementing state management with BLoC/Cubit
- Setting up routing, theming, or layouts
- Handling internationalization and localization
- Configuring CI/CD pipelines
- Addressing security concerns in mobile apps

## Reference Categories by Priority

| Priority | Category | Impact | Prefix |
|----------|----------|--------|--------|
| 1 | Architecture | CRITICAL | `arch-` |
| 2 | State Management | CRITICAL | `state-` |
| 3 | Testing | HIGH | `testing-` |
| 4 | UI Patterns | HIGH | `ui-` |
| 5 | Code Style & Conventions | MEDIUM | `code-` |
| 6 | Internationalization | MEDIUM | `i18n-` |
| 7 | Documentation | MEDIUM | `docs-` |
| 8 | Security | HIGH | `security-` |
| 9 | CI/CD | MEDIUM | `cicd-` |
| 10 | General Practices | LOW-MEDIUM | `general-` |

## How to Use

Read individual reference files for detailed explanations and code examples:

```
references/arch-layered-architecture.md
references/state-bloc-event-transformers.md
references/testing-best-practices.md
```

Each reference file contains:
- Explanation of the practice and why it matters
- Good and bad code examples with comparisons
- Implementation details and patterns
- Tips and common pitfalls

## Core Principles

1. **Layered Architecture**: Presentation, business logic, and data layers with clear boundaries
2. **Declarative over Imperative**: Declare what the UI should be, not how to build it
3. **Consistency**: Strong opinions on state management, testing, and code organization
4. **Testability**: Tests are always encouraged as a core part of development
5. **Simplicity**: Least amount of readable code to correctly model the problem space
