import 'package:flutter/material.dart' show MaterialPage;
import 'package:go_router/go_router.dart';
import 'package:hedagent/features/authentication/screens/educator_sign_up_screen.dart';
import 'package:hedagent/features/authentication/screens/email_verification_screen.dart';
import 'package:hedagent/features/authentication/screens/pending_approval_screen.dart';
import 'package:hedagent/features/authentication/screens/sign_in_screen.dart';
import 'package:hedagent/features/authentication/screens/sign_up_role_screen.dart';
import 'package:hedagent/features/authentication/screens/student_sign_up_screen.dart';
import 'package:hedagent/features/educator/models/educator_models.dart';
import 'package:hedagent/features/educator/screens/add_student_screen.dart';
import 'package:hedagent/features/educator/screens/send_alert_screen.dart';
import 'package:hedagent/features/educator/screens/student_detail_screen.dart';
import 'package:hedagent/features/goals/screens/goal_detail_screen.dart';
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
      GoRoute(
        name: RouteNames.studentDetailScreenString,
        path: '/student_detail_screen',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: StudentDetailScreen(
              student: state.extra as EducatorStudent,
            ),
          );
        },
      ),
      GoRoute(
        name: RouteNames.addStudentScreenString,
        path: '/add_student_screen',
        pageBuilder: (context, state) {
          return const MaterialPage(child: AddStudentScreen());
        },
      ),
      GoRoute(
        name: RouteNames.sendAlertScreenString,
        path: '/send_alert_screen',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SendAlertScreen(student: state.extra as EducatorStudent?),
          );
        },
      ),
      GoRoute(
        name: RouteNames.goalDetailScreenString,
        path: '/goal_detail_screen',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: GoalDetailScreen(goalId: state.extra as String),
          );
        },
      ),
    ],
  );
}
