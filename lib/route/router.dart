import 'package:flutter/material.dart' show MaterialPage;
import 'package:go_router/go_router.dart';
import 'package:hedagent/features/authentication/screens/sign_in_screen.dart';
import 'package:hedagent/features/authentication/screens/sign_up_screen.dart';
import 'package:hedagent/features/home/screens/home.dart';
import 'package:hedagent/features/onboarding/screens/onboarding_screen.dart';
import 'package:hedagent/features/onboarding/screens/splash_screen.dart';
import 'package:hedagent/route/app_router_names.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: RouteNames.splashScreenString,
        path: '/splash_screen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: RouteNames.onboardingScreenString,
        // path: '/onboarding-screen',
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: OnboardingScreen());
        },
      ),
      GoRoute(
        name: RouteNames.signInScreenString,
        path: '/sign_in_screen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignInScreen());
        },
      ),
      GoRoute(
        name: RouteNames.signUpScreenString,
        path: '/sign_up_screen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpScreen());
        },
      ),
      GoRoute(
        name: RouteNames.homeString,
        path: '/home',
        pageBuilder: (context, state) {
          return const MaterialPage(child: Home());
        },
      ),
    ],
  );
}
