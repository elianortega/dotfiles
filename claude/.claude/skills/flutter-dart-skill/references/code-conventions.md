# Conventions

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):

```
<type>(<scope>): <description>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`

## Versioning

Follow [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features, backwards compatible
- **PATCH**: Bug fixes, backwards compatible

## Changelog

Follow [Keep a Changelog](https://keepachangelog.com/):

```markdown
## [Unreleased]

### Added
- New feature description

### Changed
- Modified behavior description

### Fixed
- Bug fix description
```

## Code of Conduct

Follow the [Contributor Covenant](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).

## Documentation Framework

Follow the [Diataxis](https://diataxis.fr/) framework for documentation:

- **Tutorials**: Learning-oriented
- **How-to guides**: Problem-oriented
- **Explanation**: Understanding-oriented
- **Reference**: Information-oriented

## Linting

Use `very_good_analysis` for consistent lint rules across projects:

```yaml
# analysis_options.yaml
include: package:very_good_analysis/analysis_options.yaml
```

## BLoC Practices

Follow [Flutter BLoC opinionated practices](https://github.com/chonghorizons/flutter_bloc_opinionated_practices/wiki/Opinionated-%22Recommended%22-Practices-for-flutter_bloc) for consistent state management patterns.
