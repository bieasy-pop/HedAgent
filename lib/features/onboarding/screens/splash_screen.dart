import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';
import 'package:hedagent/features/authentication/utils/auth_navigation.dart';
import 'package:hedagent/route/app_router_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _resolveInitialRoute();
  }

  Future<void> _resolveInitialRoute() async {
    final storage = UserStorageService();
    final tokenFuture = storage.getToken();
    final userFuture = storage.getUser();

    // Keep the splash branding on screen for a minimum, deliberate beat.
    await Future.delayed(const Duration(seconds: 3));

    final token = await tokenFuture;
    final user = await userFuture;

    if (!mounted) {
      return;
    }

    if (token == null || user == null) {
      context.goNamed(RouteNames.onboardingScreenString);
      return;
    }

    // navigateAfterAuth(context, user);
    context.goNamed(RouteNames.signInScreenString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImagePath.smallIconPath,
              colorFilter: const ColorFilter.mode(
                whiteColor,
                BlendMode.srcIn,
              ),
              height: 64,
              width: 64,
            ),
            const Gap(16),
            Text(
              Texts.appNameText,
              style: AppTextStyle.secStyle.copyWith(color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
