import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/route/app_router_names.dart';

class SignUpRoleScreen extends StatelessWidget {
  const SignUpRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Texts.appNameText, style: AppTextStyle.firStyle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0 / 390 * size.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(32 / 844 * size.height),
            Text('Join EduAgent', style: AppTextStyle.twentSixStyle),
            Gap(8 / 844 * size.height),
            Text(
              'Tell us who you are so we can set up the right experience.',
              style: AppTextStyle.nintStyle,
            ),
            Gap(32 / 844 * size.height),
            _RoleCard(
              title: 'I\'m a Student',
              subtitle: 'Track your progress and get personalized insights.',
              icon: Icons.school_outlined,
              onTap: () =>
                  context.pushNamed(RouteNames.studentSignUpScreenString),
            ),
            Gap(16 / 844 * size.height),
            _RoleCard(
              title: 'I\'m an Educator',
              subtitle: 'Monitor and support your students\' learning journey.',
              icon: Icons.person_outline,
              onTap: () =>
                  context.pushNamed(RouteNames.educatorSignUpScreenString),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greyColor),
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Icon(icon, color: whiteColor),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.fourtStyle),
                  const Gap(4),
                  Text(subtitle, style: AppTextStyle.sevStyle),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: greyColor),
          ],
        ),
      ),
    );
  }
}
