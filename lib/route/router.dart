import 'package:flutter/material.dart' show MaterialPage;
import 'package:go_router/go_router.dart';
import 'package:hedagent/features/authentication/screens/educator_sign_up_screen.dart';
import 'package:hedagent/features/authentication/screens/email_verification_screen.dart';
import 'package:hedagent/features/authentication/screens/pending_approval_screen.dart';
import 'package:hedagent/features/authentication/screens/sign_in_screen.dart';
import 'package:hedagent/features/authentication/screens/sign_up_role_screen.dart';
import 'package:hedagent/features/authentication/screens/student_sign_up_screen.dart';
import 'package:hedagent/features/home/screens/home.dart';
import 'package:hedagent/features/onboarding/screens/onboarding_screen.dart';
import 'package:hedagent/features/onboarding/screens/splash_screen.dart';
import 'package:hedagent/route/app_router_names.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: RouteNames.splashScreenString,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: RouteNames.onboardingScreenString,
        // path: '/onboarding-screen',
        path: '/onboarding_screen',
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
          return const MaterialPage(child: SignUpRoleScreen());
        },
      ),
      GoRoute(
        name: RouteNames.studentSignUpScreenString,
        path: '/sign_up_screen/student',
        pageBuilder: (context, state) {
          return const MaterialPage(child: StudentSignUpScreen());
        },
      ),
      GoRoute(
        name: RouteNames.educatorSignUpScreenString,
        path: '/sign_up_screen/educator',
        pageBuilder: (context, state) {
          return const MaterialPage(child: EducatorSignUpScreen());
        },
      ),
      GoRoute(
        name: RouteNames.emailVerificationScreenString,
        path: '/email_verification_screen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: EmailVerificationScreen());
        },
      ),
      GoRoute(
        name: RouteNames.pendingApprovalScreenString,
        path: '/pending_approval_screen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: PendingApprovalScreen());
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
