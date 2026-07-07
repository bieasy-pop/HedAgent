import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';
import 'package:hedagent/route/app_router_names.dart';

class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

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
            Center(
              child: Container(
                padding: EdgeInsets.all(32.0 / 844 * size.height),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.hourglass_top_outlined,
                      color: primaryColor,
                      size: 48,
                    ),
                    Gap(16 / 844 * size.height),
                    Text(
                      'Awaiting approval',
                      style: AppTextStyle.twentSixStyle,
                    ),
                    Gap(8 / 844 * size.height),
                    Text(
                      'Your educator account is pending authorization from '
                      "a super admin. You'll be able to access the app once "
                      "it's been approved.",
                      style: AppTextStyle.nintStyle,
                    ),
                    Gap(24 / 844 * size.height),
                    elevBtn(size, () async {
                      await UserStorageService().clear();
                      if (context.mounted) {
                        context.goNamed(RouteNames.signInScreenString);
                      }
                    }, 'Log Out', null, null),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
