# Documentation

## Documentation That Lives With the Code

### README as Single Source of Truth

Every repository should answer through its README:

- Project requirements and setup instructions
- Steps to run the project (ideally one command)
- Architecture overview and rationale
- State management approach and reasoning
- Debugging tools and configuration (Sentry, session replay)
- Localization and internationalization setup

Keep documentation current -- outdated guides lose their value quickly.

### Docs Folder for Extended Guides

A `/docs` directory should contain:

- State management conventions
- Dependency injection setup
- Feature and module boundaries
- Architecture Decision Records (ADRs)
- Accessibility guidelines

### Architecture Decision Records

ADRs preserve context around significant choices, making institutional knowledge accessible to the entire team rather than only those present when decisions were made.

## Package-Level Documentation

Each package needs its own README explaining:

- The package's purpose and problems it solves
- Usage instructions
- Dependencies and environment requirements

Documentation should be understandable independently, particularly when packages are shared across multiple projects.

## Document External Tools

Tools like `build_runner` or `flutter gen-l10n` require explicit documentation:

- Include dedicated sections for critical tools
- Provide copy-pasteable commands, file locations, and regeneration steps
- Clarify when and why each tool exists
- Document where configuration lives
- Explain common pitfalls and edge cases

Define team conventions rather than just procedures to prevent fragmentation.

## Coding Standards

Key areas to standardize:

- **State Management Patterns**: Document preferred approaches and common mistakes
- **Dependency Injection**: Explain philosophy, lifecycle expectations, and testability benefits
- **Folder Structures**: Enforce consistency in modular or feature-driven architectures
- **Naming Conventions & Lint Rules**: Use tools like `very_good_analysis` for automated enforcement

## Documenting Design Systems & Widgets

- Enforce documentation of all public widgets and APIs
- Include clear descriptions, required vs optional parameters, usage constraints
- Explain when and why to use each component, not just what it looks like
