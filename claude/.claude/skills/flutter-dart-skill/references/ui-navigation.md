# Routing Overview

## GoRouter

GoRouter is the recommended routing package for Flutter applications. It provides declarative, URL-based routing with support for deep linking, redirects, and type-safe routes.

## Route Structure

### Type-Safe Routes

Use `go_router_builder` with code generation for type-safe route definitions:

```dart
@TypedGoRoute<FlutterNewsPageRoute>(
  name: 'flutterNews',
  path: '/flutter-news',
)
@immutable
class FlutterNewsPageRoute extends GoRouteData {
  @override
  Widget build(context, state) {
    return const FlutterNewsPage();
  }
}
```

### Sub-Routes

Organize routes hierarchically:

```dart
@TypedGoRoute<TechnologyPageRoute>(
  name: 'technology',
  path: '/technology',
  routes: [
    TypedGoRoute<FlutterPageRoute>(
      name: 'flutter',
      path: 'flutter',
      routes: [
        TypedGoRoute<FlutterNewsPageRoute>(
          name: 'flutterNews',
          path: 'news',
        ),
      ],
    ),
  ],
)
```

## Navigation Methods

### Use `go` for Standard Navigation

Use GoRouter's `go` methods for navigation. It pushes a new route and updates the browser URL.

```dart
FlutterNewsPageRoute().go(context);
```

### Use `push` for Dialogs and Data Return

Use `push` when expecting data from a popped route (e.g., dialogs collecting user input). `push` does not update the URL address bar.

### Use `go` over `push` by Default

`go` ensures the back button displays when the current route has a parent. Root paths do not display a back button.

## URL Best Practices

### Use Hyphens for Word Separation

**Good:**

```
/user/update-address
```

**Bad:**

```
/user/update_address
/user/updateAddress
```

### Navigate by Name over Path

Because paths can change over time, navigate by name to avoid sync issues:

**Good:**

```dart
context.goNamed('flutterNews');
```

### Use Extension Methods

Use `BuildContext` extensions for consistency:

**Good:**

```dart
context.goNamed('flutterNews');
```

**Bad:**

```dart
GoRouter.of(context).goNamed('flutterNews');
```

## Parameters

### Path Parameters

Use for identifying specific resources:

```dart
@TypedGoRoute<FlutterArticlePageRoute>(
  name: 'flutterArticle',
  path: 'article/:id',
)
@immutable
class FlutterArticlePageRoute extends GoRouteData {
  const FlutterArticlePageRoute({required this.id});
  final String id;

  @override
  Widget build(context, state) {
    return FlutterArticlePage(id: id);
  }
}
```

```dart
FlutterArticlePageRoute(id: article.id).go(context);
```

### Query Parameters

Use for filtering or sorting:

```dart
@TypedGoRoute<FlutterArticlesPageRoute>(
  name: 'flutterArticles',
  path: 'articles',
)
@immutable
class FlutterArticlesPageRoute extends GoRouteData {
  const FlutterArticlesPageRoute({this.date, this.category});
  final String? date;
  final String? category;

  @override
  Widget build(context, state) {
    return FlutterArticlesPage(date: date, category: category);
  }
}
```

### Avoid `extra` Parameter

The `extra` parameter does not work on web and cannot be used for deep linking. Pass identifiers via path parameters instead and fetch data in the destination page.

**Good:**

```dart
FlutterArticlePageRoute(id: state.article.id).go(context);
```

**Bad:**

```dart
FlutterArticlePageRoute(article: article).go(context);  // passing whole object
```

## Redirects

### Root-Level Redirect

```dart
GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final status = context.read<AppBloc>().state.status;
    if (status == AppStatus.unauthenticated) {
      return SignInPageRoute().location;
    }
    return null;
  },
  routes: $appRoutes,
);
```

### Sub-Route Redirect

Parent route redirects apply to all sub-routes:

```dart
@immutable
class PremiumPageRoute extends GoRouteData {
  @override
  String? redirect(context, state) {
    final status = context.read<AppBloc>().state.user.status;
    if (status != UserStatus.premium) {
      return RestrictedPageRoute().location;
    }
    return null;
  }
}
```

This protects `/premium`, `/premium/shows`, and `/premium/merch` with a single redirect.
