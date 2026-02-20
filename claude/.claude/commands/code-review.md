# /code-review Command

## Description
Perform a systematic code review.

## Usage
```
/code-review [file or PR]
```

## Checks
- Correctness
- Security vulnerabilities
- Performance issues
- Code maintainability
- Test coverage

## Output
Structured review with:
- Summary assessment
- Blockers (must fix)
- Suggestions (should fix)
- Questions (need clarification)

## Example
```
/code-review src/auth/login.ts
/code-review #123
```
