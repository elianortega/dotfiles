# CI/CD

## Overview

Continuous Integration and Continuous Delivery are essential for maintaining code quality and enabling rapid, reliable releases.

## CI Pipeline

### Essential Checks

1. **Formatting**: `dart format --set-exit-if-changed .`
2. **Analysis**: `dart analyze --fatal-infos --fatal-warnings`
3. **Tests**: `flutter test` or `very_good test`
4. **Coverage**: Generate and verify test coverage reports

### Recommended CI Workflow

```yaml
# Example GitHub Actions workflow
name: CI
on: [pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: dart format --set-exit-if-changed .
      - run: dart analyze --fatal-infos --fatal-warnings
      - run: flutter test --test-randomize-ordering-seed random
```

## CD Pipeline

### Code Signing

Use services like [Codemagic](https://codemagic.io/) to simplify code signing and distribution.

### Release Process

1. Update version in `pubspec.yaml`
2. Update CHANGELOG.md
3. Create git tag
4. Build release artifacts
5. Deploy to stores

## Best Practices

- Run CI on every pull request
- Fail fast on formatting and analysis issues
- Run tests with random ordering to catch flaky tests
- Use caching for dependencies to speed up builds
- Automate release builds and deployments
- Use environment variables for secrets (never hardcode)
- Use `very_good_workflows` for reusable GitHub Actions
