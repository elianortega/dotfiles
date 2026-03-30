---
name: nav-migration-review
description: >
  Code review skill for Nuvigator-to-i_nuvigator migration PRs.
  Validates additive-only changes, FF gating, 1:1 counterpart logic,
  app router registration, test coverage, and code style.
  Use when reviewing any nav-migration PR.
version: "1.2.0"
---

# Nav Migration PR Review

Review a nav-migration PR against the migration guidelines. This skill does NOT duplicate the rules from `nav-migration-simple` or `nav-migration-test` -- it references them. Read those skills for the full rule set; this skill defines the **review checklist and verification process**.

## Input

```
/nav-migration-review <PR_URL_OR_NUMBER>
```

## Phase 0: Locate Reference Skills

Before starting the review, resolve the install location of `nav-migration-simple` and `nav-migration-test`. Check paths in this order and use the **first match found**:

1. `~/.claude/skills/nav-migration-simple/SKILL.md` (user-global Claude Code)
2. `~/.cursor/skills/nav-migration-simple/SKILL.md` (user-global Cursor)
3. `.claude/skills/nav-migration-simple/SKILL.md` (project-local)

Repeat for `nav-migration-test`. Store the resolved base paths as `$MIGRATION_SKILL_DIR` and `$TEST_SKILL_DIR`.

When the review needs to consult a reference file (e.g., `05-common-mistakes.md`, `02-navigation-api-mapping.md`), read it from `$MIGRATION_SKILL_DIR/references/<file>`. Do NOT guess content from memory -- always read the file to ensure the latest version is used.

If neither skill is found, warn the user: "Reference skills not installed. Review will use inline rules only -- results may be incomplete."

## Process

### Phase 1: Fetch PR State

1. Fetch PR metadata: title, author, state, files, additions, deletions, mergeable status.
2. Fetch all commits (check for fix-up commits that may address earlier feedback).
3. Fetch all reviews and review comments (check which are resolved vs open).
4. Fetch the full diff.
5. If `mergeable` is `CONFLICTING`, flag as **BLOCKER** immediately.
6. Check diff for committed lock files (`Podfile.lock`, `pubspec.lock`, `macos/Podfile.lock`). Flag as **BLOCKER** -- these should never be committed in migration PRs.

### Phase 2: Identify the Package

From the diff, identify the target package name (e.g., `boleto_payment`). This is used for all subsequent checks.

### Phase 3: Safety Checks (Blockers)

Run these checks first. Any failure is a **BLOCKER** -- PR cannot merge.

#### 3.1 App Router Registration

Check `packages/root/lib/src/nuvigator_app_router.dart` diff for:

- [ ] `isINuvigatorEnabledForPackage(packageName: '{package_name}')` conditional exists
- [ ] V2 path uses `RouteAdapter.fromAppConfig(appConfig: appConfig, route: r)` (NOT hardcoded `RouteAdapter(adapter: NuRouteAdapter.nuvigator, ...)` -- see `nav-migration-simple` Mistake #8)
- [ ] V1 fallback preserves original registration (including `_routesWithPackageName` if it was there)
- [ ] No unrelated changes in the app router file (formatting, trailing commas on other routes -- see Mistake #10)

If the V2 routes are defined but NOT registered in the app router, flag as **CRITICAL**: "FF is dead -- V2 routes will never be used."

#### 3.2 Additive-Only Principle

The migration MUST be additive. Check every modified V1 file:

- [ ] No V1 NuRoute/NuRouter classes deleted or renamed
- [ ] No V1 function signatures changed (e.g., `openLink(NuvigatorState, String)` -> `openLink(BuildContext, String)`)
- [ ] No V1 private classes made public (e.g., `_HomeModelState` -> `HomeModelState`)
- [ ] No V1 constructor parameters added or changed
- [ ] No V1 imports removed (both `nuvigator` AND `i_nuvigator` should coexist in widget files)
- [ ] No files outside the target package modified (except `nuvigator_app_router.dart`)

**The rule**: If the FF is turned OFF, every V1 code path must behave exactly as before the PR. Any change to a V1 API contract, class name, or function signature is a violation.

**Exception**: Adding FF-guarded dual-path navigation calls to V1 widget files IS allowed (this is the migration itself).

#### 3.3 No Dead/WIP Code

- [ ] No placeholder routes with stub content (e.g., `Container(child: Text('TODO'))`)
- [ ] No routes defined but excluded from the getter/registry without clear documentation
- [ ] No `FIXME` comments in new test files
- [ ] Migration scope is limited to existing V1 routes -- do not introduce new screens

#### 3.4 Feature Flag Guards on Widget Navigation

Every `Nuvigator.of(context)` replacement in widget files (NOT inside `IRoute.build()`) must be behind a feature flag guard:

```dart
final isINuvigatorEnabled = IAppConfig.of(context)
    .isINuvigatorEnabledForPackage(packageName: '{package_name}');
if (isINuvigatorEnabled) {
  IRouter.of(context).method(...);
} else {
  Nuvigator.of(context).method(...);
}
```

- [ ] ALL widget file nav calls have dual-path FF guards
- [ ] Helper functions that centralize FF checks are acceptable (e.g., `mutualFundsPop(context)`)
- [ ] Navigation calls inside `IRoute.build()` / `IShellRoute.onError()` / `IShellRoute.init()` do NOT need FF guards (the shell gates the tree)
- [ ] Both `nuvigator` and `i_nuvigator` imports kept in widget files
- [ ] `app_config` import added for FF check

#### 3.5 No Nuvigator-inside-IRoute (Decoupling Verification)

**This is a BLOCKER.** The entire purpose of the migration is to decouple from Nuvigator. Scan ALL new `lib/src/i_nuvigator/` files for:

- [ ] No `Nuvigator(` widget instantiation inside any IRoute `build()` or IShellRoute code
- [ ] No `NuRouter` subclass defined in V2 files (e.g., `class InnerNuRouter extends NuRouter`)
- [ ] No `.toNuRoute()` calls in `lib/` files -- this is a test-only API from `i_nuvigator_nuvigator`
- [ ] No `import 'package:i_nuvigator_nuvigator/...'` in `lib/` files -- test adapter, not production
- [ ] No `import 'package:nuvigator/...'` in new V2 files under `lib/src/i_nuvigator/` (V2 code should only import `i_nuvigator`)

**The anti-pattern** (Mistake #24): An IRoute whose `build()` renders `Nuvigator(router: SomeNuRouter(...))`. This adds indirection without decoupling -- the V2 route still depends on the V1 engine internally. Child routes are often IRoutes converted back to NuRoutes via `.toNuRoute()`, creating a pointless IRoute -> NuRoute -> Nuvigator round-trip.

**The fix**: For flows with nested sub-routes, use `IShellRoute` with child `IRoute`s in the `routes` getter. IRouter handles child navigation natively -- no Nuvigator needed. See RULE-05 and RULE-12 in the migration skill.

**Exception**: V1 code (existing NuRouter/NuRoute files outside `i_nuvigator/`) may obviously still use Nuvigator -- only V2 code is checked.

#### 3.6 1:1 Counterpart Verification

For every V2 construct, verify it has a logical V1 counterpart:

**Routes:**
- [ ] Every V1 NuRoute has a corresponding V2 IRoute with the same screen/widget
- [ ] Presentation types match: `nuTakeoverScreenType` -> `TakeoverPresentation()`, `nuTakeoverFullScreenType` -> `TakeoverPresentation(fullscreenDialog: true)`, `nuBottomSheetScreenType` -> `BottomSheetPresentation(...)`. If no direct equivalent exists, flag for engineer sign-off (see `nav-migration-simple` `04-edge-cases.md` Section 1).
- [ ] Route paths are preserved (no casing changes -- see Mistake #14)
- [ ] All entry points / legacy deep links have corresponding V2 routes (see Mistake #22)

**Providers (buildWrapper):**
- [ ] Provider count in V2 IShellRoute `buildWrapper` matches V1 NuRouter `buildWrapper` or NuRoute `build`
- [ ] Provider types and creation logic are identical
- [ ] No providers silently dropped (see Mistake #19)

**External DI Module (if applicable):**
Some packages use an external injector module (e.g., `loadDependencies()`, a `Module` class, a `provide_*` file) instead of inline `MultiProvider`. If ANY file outside `lib/src/i_nuvigator/` that wires DI is modified:
- [ ] V1 path intact: every conditional provider has an `else` returning the original V1 class with identical logic
- [ ] Interface widening is backward-compatible: V1 class implements the new interface (`class XxxNavigation implements IXxxNavigation`)
- [ ] No providers removed from the V1 execution path
- [ ] No DI changes for non-navigation concerns (Mistake #10)

**Navigation calls inside IRoute.build():**
- [ ] Analytics calls carried forward from V1 `NuRouteBuilder.builder()` (see Mistake #11)
- [ ] Parameter extraction matches V1 (same cast types, null handling -- see Mistake #17)
- [ ] `arguments:` vs `parameters:` usage correct (see Mistake #1): push/pushReplacement use `arguments:`, open/openDeepLink use `parameters:`

**Async init (if applicable):**
- [ ] `awaitForInit`, `loadingWidget`, `onError`, `init()` carried forward from V1 NuRouter

### Phase 4: Structure Checks

#### 4.1 Directory Structure and File Naming

- [ ] New files under `lib/src/i_nuvigator/` (RULE-02)
- [ ] Exactly two files with canonical names: `{package}.dart` (shell + wrapper) and `router.dart` (enums + routes). Monolithic layout, no `routes/` subdirectory.
- [ ] No non-standard file names like `inuv_*.dart`, `i_nuvigator_*.dart`, `inuv_shell_inner_nuvigator.dart`, etc. (Mistake #26)
- [ ] No extra files beyond the two canonical ones (e.g., no `inuv_registry.dart`, `inuv_shells.dart`, scope files). If scoping widgets are needed, they belong inside `{package}.dart`.

#### 4.2 IShellRoute Decision

Per RULE-05 decision tree:
- Shared DI across routes -> IShellRoute with all providers
- No shared DI / single route -> Plain IRoute(s) with Boundary in each `build()`

#### 4.3 Boundary/PackageInfo Wrapper

- [ ] **IShellRoute**: Dedicated `_{Package}EntryRouteBuildWrapper` StatelessWidget with `builder` callback. Boundary OUTSIDE MultiProvider (see RULE-06, Mistake #2).
- [ ] **Plain IRoute**: Boundary wraps the return of `build()` (Template-17).

#### 4.4 Export Pattern

- [ ] Package library file exports `{package}IRoutes` getter returning `List<IBaseRoute>` (RULE-07, RULE-11)
- [ ] Individual IRoute classes NOT exported (implementation details). Only getter + enums.
- [ ] V1 exports unchanged

#### 4.5 Dependencies

- [ ] `i_nuvigator` added to dependencies
- [ ] `app_config` added to dependencies (if widget files have FF guards)
- [ ] `i_nuvigator_nuvigator` in `dev_dependencies` ONLY (NOT in `dependencies`) -- see Mistake #25
- [ ] No `import 'package:i_nuvigator_nuvigator/...'` in any `lib/` file (grep for it) -- test adapter only
- [ ] No `.toNuRoute()` calls in `lib/` files -- test-only API
- [ ] `nuvigator` kept (NOT removed)
- [ ] No dependencies removed or downgraded

### Phase 5: Code Style Checks

#### 5.1 App Router Formatting

- [ ] Uses `...[  ]` spread pattern (not bare spread)
- [ ] Indentation consistent with other migrations
- [ ] No unrelated formatting changes

#### 5.2 Cross-Package Consistency

Check that patterns match what other already-merged migrations use:
- [ ] `IAppConfig.of(context).isINuvigatorEnabledForPackage(...)` -- no try-catch wrapper unless the package has a specific reason
- [ ] FF helper extraction pattern consistent (private `_isINuvigatorEnabled` function or centralized helper file)
- [ ] No novel navigation patterns that diverge from established migrations without documented justification

#### 5.3 Navigation Method Categories

Flag these in the review output:
- **GREEN methods**: `pop`, `push`, `pushReplacement`, `open`, `openDeepLink`, `canPop`, `canOpen`, `maybePop`, `currentPath`, `pushRoute`, `closeFlow` -- direct replacement
- **YELLOW methods**: `popUntilLegacy`, `pushAndRemoveUntilLegacy` -- flag for M4.2 follow-up
- **RED methods**: `parentPop`, `rootPop` -- flag for M4.2 case-by-case resolution

#### 5.4 Parameter Mapping

Verify correct parameter names per `02-navigation-api-mapping.md`:
- `push`/`pushReplacement`/`pushAndRemoveUntilLegacy` -> `arguments:` (in-memory objects)
- `open`/`openDeepLink` -> `parameters:` (URL query strings)
- `DeepLinkPushMethod.PushReplacement` -> `PushMethodType.pushReplacement`
- `DeepLinkPushMethod.PopAndPush` -> `PushMethodType.popAndPush`

### Phase 6: Test Checks

Per `nav-migration-test` skill:

- [ ] No original test files modified (non-negotiable)
- [ ] `i_nuvigator_route_test.dart` exists if original `route_test.dart` exists
- [ ] Integration test counterparts exist for each original integration test
- [ ] Tests use `RouteRegistryBuilder` + `IAppConfig` + `Nuvigator(router: .toNuRouter())` pattern
- [ ] `IAppConfig` provider with `jsonEncode(['{package_name}'])` in test setup
- [ ] `pumpAndSettle` after setup
- [ ] Every V1 nuvigator-based test has an `i_nuvigator_*` counterpart (except tests that don't use router -- skip those)
- [ ] `canOpen` tests: NuRoute-specific, V2 counterpart uses `IRouter.of(context).canOpen()` or converted `.toNuRoute().canOpen()` -- or explicitly noted as NuRoute-specific
- [ ] IAppConfig in tests uses `jsonEncode(['package_name'])` (String), NOT a raw `List` -- verify consistency with other migrations
- [ ] No `FIXME` or `TODO` comments in new test files (indicates incomplete work)

### Phase 7: Existing Review Comments

- [ ] Check if there are existing review comments (CHANGES_REQUESTED)
- [ ] For each comment, verify if later commits addressed it
- [ ] Report which comments are resolved vs still open

### Phase 8: Output

Generate a structured review with:

```
## PR #{number} Review: `{package}` i_nuvigator Migration

**Status**: {OPEN/APPROVED/CHANGES_REQUESTED} | **Files**: {N} | **Mergeable**: {YES/CONFLICTING}

### Blockers
{table of blocking issues with file, line, message -- or "None"}

### Issues
{table of non-blocking issues with file, line, message, severity -- or "None"}

### Checklist
{table showing each rule and PASS/FAIL status}

### Verdict
{APPROVE / CHANGES_REQUESTED / reason}
```

If there are issues to flag, provide copy-paste ready comments:

```
### Comments for GitHub

| # | File | Line | Message |
|---|------|------|---------|
```

## Quick Reference: Common Mistakes

These are the most frequently seen issues across migration PRs (from `nav-migration-simple` `05-common-mistakes.md`):

| # | Mistake | Check |
|---|---------|-------|
| 1 | arguments vs parameters | `push` uses `arguments:`, `open` uses `parameters:` |
| 2 | Missing Boundary/PackageInfo | Must be outermost widget |
| 8 | Hardcoded RouteAdapter | Must use `RouteAdapter.fromAppConfig` |
| 9 | Removing V1 code | Migration is ADDITIVE |
| 10 | Modifying non-navigation code | Only touch navigation layer |
| 11 | Dropping analytics | Replicate from V1 `NuRouteBuilder.builder()` |
| 12 | Inventing presentation params | Mirror original exactly |
| 13 | Dropping providers | Count must match V1 -- check both `buildWrapper` AND any external DI module |
| 13b | Broken DI V1 path | If DI module modified: every conditional provider must have an `else` returning the original V1 class with identical logic |
| 14 | Normalizing path casing | Preserve verbatim |
| 15 | Modifying test files | Tests are ADDITIVE |
| 17 | Relaxing type casts | Preserve exact casts |
| 18 | Missing FF guard on widget nav | ALL widget nav calls need guard |
| 19 | Making things disappear | Every provider/widget/param must carry forward |
| 20 | Duplicating providers | One place only (except analytics double-provider) |
| 22 | Missing legacy routes | Every entry point must be in routes list |
| 23 | Wrong AppConfig pattern | Detect package's existing pattern first |
| 24 | Nuvigator-in-IRoute wrapping | `IRoute.build()` must NOT embed `Nuvigator(router:...)` -- use IShellRoute for nested flows |
| 25 | i_nuvigator_nuvigator in production | `.toNuRoute()` and `i_nuvigator_nuvigator` imports are test-only -- never in `lib/` |
| 26 | Non-standard file naming | Exactly `{package}.dart` + `router.dart` -- no `inuv_*.dart` variants |

## Reference Skills

Paths are relative to the resolved `$MIGRATION_SKILL_DIR` and `$TEST_SKILL_DIR` from Phase 0.

| File (relative to skill dir) | Purpose | When to read |
|---|---|---|
| `$MIGRATION_SKILL_DIR/SKILL.md` | Full migration rules (RULE-01 through RULE-12) | Phase 3-4: verify structure and safety |
| `$MIGRATION_SKILL_DIR/references/01-migration-rules.md` | Detailed rule constraints | Phase 3.4: 1:1 counterpart verification |
| `$MIGRATION_SKILL_DIR/references/02-navigation-api-mapping.md` | GREEN/YELLOW/RED method table, parameter mapping | Phase 5.3-5.4: method categories, param checks |
| `$MIGRATION_SKILL_DIR/references/05-common-mistakes.md` | 23 named mistakes | Phase 3-5: cross-reference any suspicious pattern |
| `$MIGRATION_SKILL_DIR/references/06-code-templates.md` | Code templates | Phase 4: verify structure matches templates |
| `$MIGRATION_SKILL_DIR/references/08-nuvigator-app-router.md` | App router registration pattern | Phase 3.1: verify app router correctness |
| `$TEST_SKILL_DIR/SKILL.md` | Test migration rules and checklist | Phase 6: verify test coverage |

Read these files on demand -- do not preload all of them. Only read when a specific check requires the reference.
