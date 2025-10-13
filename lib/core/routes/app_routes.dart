import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:litlore/core/network/local/navigation_services.dart';
import 'package:litlore/features/authentication/presentation/views/register_view.dart';
import 'package:litlore/features/authentication/presentation/views/onboarding_view.dart';
import 'package:litlore/features/home/presentation/views/book_details_view.dart';

import 'package:litlore/features/home/presentation/views/home_view.dart';

import 'package:litlore/features/search/presentation/views/search_view.dart';
import 'package:litlore/features/authentication/presentation/views/splash_view.dart';
import 'package:nb_utils/nb_utils.dart';


 class AppRouter{
  static Page _animateRouteBuilder(Widget widget, {PageRouteAnimation? pageRouteAnimation, Duration? duration}) {
    // ✅ Works on web & all platforms
  

    return CustomTransitionPage(
      child: widget,
      fullscreenDialog: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (pageRouteAnimation) {
          case PageRouteAnimation.Fade:
            return FadeTransition(opacity: animation, child: child);

          case PageRouteAnimation.Scale:
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
              child: child,
            );

          case PageRouteAnimation.Rotate:
            return RotationTransition(
              turns: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
              child: child,
            );

          case PageRouteAnimation.Slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
              child: child,
            );

          case PageRouteAnimation.SlideBottomTop:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
              child: child,
            );

          default:
            return FadeTransition(opacity: animation, child: child);
        }
      },
      transitionDuration: duration ?? const Duration(milliseconds: 500),
    );
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
          pageRouteAnimation: args['pageAnimation'] ?? PageRouteAnimation.Fade,
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
          pageRouteAnimation: args['pageAnimation'] ?? PageRouteAnimation.Fade,
        );
      },
    ),
    GoRoute(
      path: BookDetailsView.routeName,
      pageBuilder: (context, state) {
        final Map<String, dynamic> args =
            state.extra as Map<String, dynamic>? ?? {};
        return _animateRouteBuilder(
          const BookDetailsView(),
          pageRouteAnimation: args['pageAnimation'] ?? PageRouteAnimation.Fade,
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
          pageRouteAnimation: args['pageAnimation'] ?? PageRouteAnimation.Fade,
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
          pageRouteAnimation: args['pageAnimation'] ?? PageRouteAnimation.Fade,
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
          pageRouteAnimation: args['pageAnimation'] ?? PageRouteAnimation.Fade,
        );
      },
    ),
  ],
);

 }