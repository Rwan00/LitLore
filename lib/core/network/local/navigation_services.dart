import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  NavigationService();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState? get navigator => navigatorKey.currentState;

  static Future<dynamic> navigateTo(String path, {Object? extra}) {
    return GoRouter.of(navigatorKey.currentContext!).push(path, extra: extra);
  }

  static void goBack<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }

  static void pushNamedAndRemoveUntil(String path, {Object? extra}) {
    final context = navigatorKey.currentContext;
    if (context == null) {
      print('Navigator context is null. Navigation aborted.');
      return;
    }
    // GoRouter.go() replaces the whole stack
    GoRouter.of(context).go(path, extra: extra);
  }

  static Future<dynamic> push(String path, {Object? extra}) {
    return GoRouter.of(navigatorKey.currentContext!).push(path, extra: extra);
  }

  static Future<dynamic> pushReplacement(String path, {Object? extra}) {
    return GoRouter.of(navigatorKey.currentContext!).pushReplacement(path, extra: extra);
  }

  static void goTo(String path, {Object? extra}) {
    final context = navigatorKey.currentContext;
    if (context == null) {
      // Optionally log or throw a user-friendly error
      print('Navigator context is null. Navigation aborted.');
      return;
    }
    final router = GoRouter.of(context);
    final currentLocation = router.routerDelegate.currentConfiguration.matches.last.matchedLocation;
    if (currentLocation == path) return;
    router.go(path, extra: extra);
  }

  static void popUntil(String routeName) {
    final router = GoRouter.of(navigatorKey.currentContext!);
    while (router.routerDelegate.currentConfiguration.matches.last.matchedLocation != routeName) {
      if (!navigatorKey.currentState!.canPop()) break;
      navigatorKey.currentState!.pop();
    }
  }

  static void printNavigationStack() {
    final router = GoRouter.of(navigatorKey.currentContext!);
    final stack = router.routerDelegate.currentConfiguration.matches;

    for (int i = 0; i < stack.length; i++) {}
  }

  static String getCurrentRoute() {
    return GoRouter.of(navigatorKey.currentContext!).routerDelegate.currentConfiguration.matches.last.matchedLocation;
  }

  static bool hasRoute(String routeName) {
    final router = GoRouter.of(navigatorKey.currentContext!);
    return router.routerDelegate.currentConfiguration.matches.any((match) => match.matchedLocation == routeName);
  }
}
