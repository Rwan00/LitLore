import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:litlore/core/network/local/cache_helper.dart';
import 'package:litlore/core/network/local/navigation_services.dart';
import 'package:litlore/features/authentication/presentation/views/login_view.dart';
import 'package:litlore/features/authentication/presentation/views/register_view.dart';
import 'package:litlore/features/authentication/presentation/views/onboarding_view.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/presentation/views/book_details_view.dart';
import 'package:litlore/features/home/presentation/views/category_books_view.dart';
import 'package:litlore/features/home/presentation/views/home_view.dart';
import 'package:litlore/features/search/presentation/views/search_view.dart';
import 'package:litlore/features/authentication/presentation/views/splash_view.dart';
import 'package:nb_utils/nb_utils.dart';

class AppRouter {
  static Page _animateRouteBuilder(
    Widget widget, {
    PageRouteAnimation? pageRouteAnimation,
    Duration? duration,
  }) {
    return CustomTransitionPage(
      child: widget,
      fullscreenDialog: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (pageRouteAnimation) {
          case PageRouteAnimation.Fade:
            return FadeTransition(opacity: animation, child: child);

          case PageRouteAnimation.Scale:
            return ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
              ),
              child: child,
            );

          case PageRouteAnimation.Rotate:
            return RotationTransition(
              turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            );

          case PageRouteAnimation.Slide:
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  ),
              child: child,
            );

          case PageRouteAnimation.SlideBottomTop:
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  ),
              child: child,
            );

          default:
            return FadeTransition(opacity: animation, child: child);
        }
      },
      transitionDuration: duration ?? const Duration(milliseconds: 500),
    );
  }

  /// Determines which screens are considered "auth screens"
  static const List<String> authScreens = [
    OnBoardingScreen.routeName,
    RegisterView.routeName,
    SplashView.routeName,
  ];

  /// Determines which screens require authentication
  static const List<String> protectedScreens = [
    HomeView.routeName,
    BookDetailsView.routeName,
    SearchView.routeName,
  ];

  /// Checks if user is properly authenticated by verifying tokens
  static Future<bool> _isUserAuthenticated() async {
    try {
      final accessToken = await AppCacheHelper.getSecureString(
        key: AppCacheHelper.accessTokenKey,
      );
      final refreshToken = await AppCacheHelper.getSecureString(
        key: AppCacheHelper.refreshTokenKey,
      );

      return accessToken.isNotEmpty || refreshToken.isNotEmpty;
    } catch (e) {
      print('❌ Error checking authentication: $e');
      return false;
    }
  }

  /// Debug logging for redirect logic
  static void _logRedirectDebug({
    required String location,
    required bool isAuthenticated,
    required String redirectTo,
  }) {
    print('🧭 Router Redirect:');
    print('  Location: $location');
    print('  Authenticated: $isAuthenticated');
    print('  Redirect to: $redirectTo');
  }

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: SplashView.routeName,
    routes: <RouteBase>[
      GoRoute(
        path: SplashView.routeName,
        pageBuilder: (context, state) {
          final Map<String, dynamic> args =
              state.extra as Map<String, dynamic>? ?? {};
          return _animateRouteBuilder(
            const SplashView(),
            pageRouteAnimation:
                args['pageAnimation'] ?? PageRouteAnimation.Fade,
          );
        },
      ),
      GoRoute(
        path: HomeView.routeName,
        pageBuilder: (context, state) {
          final Map<String, dynamic> args =
              state.extra as Map<String, dynamic>? ?? {};
          return _animateRouteBuilder(
            const HomeView(),
            pageRouteAnimation:
                args['pageAnimation'] ?? PageRouteAnimation.Fade,
          );
        },
      ),
      GoRoute(
        path: BookDetailsView.routeName,
        pageBuilder: (context, state) {
          final Map<String, dynamic> args =
              state.extra as Map<String, dynamic>? ?? {};
             
          return _animateRouteBuilder(
             BookDetailsView(book: args['book'],),
            pageRouteAnimation:
                args['pageAnimation'] ?? PageRouteAnimation.Fade,
          );
        },
      ),
      GoRoute(
        path: CategoryBooksView.routeName,
        pageBuilder: (context, state) {
          final Map<String, dynamic> args =
              state.extra as Map<String, dynamic>? ?? {};
             
          return _animateRouteBuilder(
             CategoryBooksView(title: args['title'],),
            pageRouteAnimation:
                args['pageAnimation'] ?? PageRouteAnimation.Fade,
          );
        },
      ),
      GoRoute(
        path: SearchView.routeName,
        pageBuilder: (context, state) {
          final Map<String, dynamic> args =
              state.extra as Map<String, dynamic>? ?? {};
          return _animateRouteBuilder(
            const SearchView(),
            pageRouteAnimation:
                args['pageAnimation'] ?? PageRouteAnimation.Fade,
          );
        },
      ),
      GoRoute(
        path: OnBoardingScreen.routeName,
        pageBuilder: (context, state) {
          final Map<String, dynamic> args =
              state.extra as Map<String, dynamic>? ?? {};
          return _animateRouteBuilder(
            const OnBoardingScreen(),
            pageRouteAnimation:
                args['pageAnimation'] ?? PageRouteAnimation.Fade,
          );
        },
      ),
      GoRoute(
        path: RegisterView.routeName,
        pageBuilder: (context, state) {
          final Map<String, dynamic> args =
              state.extra as Map<String, dynamic>? ?? {};
          return _animateRouteBuilder(
            const RegisterView(),
            pageRouteAnimation:
                args['pageAnimation'] ?? PageRouteAnimation.Fade,
          );
        },
      ),
      GoRoute(
        path: LoginView.routeName,
        pageBuilder: (context, state) {
          final Map<String, dynamic> args =
              state.extra as Map<String, dynamic>? ?? {};
          return _animateRouteBuilder(
            const LoginView(),
            pageRouteAnimation:
                args['pageAnimation'] ?? PageRouteAnimation.Fade,
          );
        },
      ),
    ],
    redirect: (context, state) async {
      try {
        final currentLocation = state.matchedLocation;

        // Check authentication status
        final isAuthenticated = await _isUserAuthenticated();

        // 1. If user is authenticated and tries to access auth screens,
        // redirect to home (except for splash which handles the transition)
        if (isAuthenticated &&
            authScreens.contains(currentLocation) &&
            currentLocation != SplashView.routeName) {
          _logRedirectDebug(
            location: currentLocation,
            isAuthenticated: isAuthenticated,
            redirectTo: HomeView.routeName,
          );
          return HomeView.routeName;
        }

        // 2. If user is NOT authenticated and tries to access protected screens,
        // redirect to onboarding
        if (!isAuthenticated && protectedScreens.contains(currentLocation)) {
          _logRedirectDebug(
            location: currentLocation,
            isAuthenticated: isAuthenticated,
            redirectTo: OnBoardingScreen.routeName,
          );
          return OnBoardingScreen.routeName;
        }

        // 3. Splash screen logic: Check if user should proceed to onboarding or home
        if (currentLocation == SplashView.routeName) {
          if (isAuthenticated) {
            print('✅ Authenticated user detected, navigating to home');
            return HomeView.routeName;
          } else {
            print('🚀 New user detected, navigating to onboarding');
            return OnBoardingScreen.routeName;
          }
        }

        // 4. No redirect needed
        print('✅ No redirect needed for: $currentLocation');
        return null;
      } catch (e) {
        print('❌ Error in router redirect: $e');
        // On error, redirect to splash for safe state recovery
        return SplashView.routeName;
      }
    },
  );
}
