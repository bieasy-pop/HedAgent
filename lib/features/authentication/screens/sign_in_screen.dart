import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/route/app_router_names.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0 / 390 * size.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(20 / 844 * size.height),
            Center(
              child: Container(
                height: 64,
                width: 64,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: SvgPicture.asset(
                  colorFilter: ColorFilter.mode(whiteColor, BlendMode.srcIn),
                  ImagePath.smallIconPath,
                  height: 12,
                  width: 12,
                ),
              ),
            ),
            Text(Texts.appNameText, style: AppTextStyle.firStyle),
            Text(
              textAlign: TextAlign.center,
              Texts.welcomeText,
              style: AppTextStyle.sixStyle,
            ),
            Gap(24 / 844 * size.height),
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Texts.emailLabelText, style: AppTextStyle.sevStyle),
                  Gap(8 / 844 * size.height),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: greyColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                  Gap(24 / 844 * size.height),
                  Text(Texts.passwordLabelText, style: AppTextStyle.sevStyle),
                  Gap(8 / 844 * size.height),
                  TextField(
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      hintText: '***********',
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                        color: greyColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          isVisible
                              ? Icons.visibility_sharp
                              : Icons.visibility_off_outlined,
                          color: greyColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                  Gap(24 / 844 * size.height),
                  elevBtn(
                    size,
                    () => context.goNamed(RouteNames.homeString),
                    Texts.signInText,
                    null,
                    null,
                  ),
                  // Gap(32 / 844 * size.height),
                  // Row(children: [
                  //   const Expanded(child: Divider(color: greyColor)),
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //     child: Text('OR', style: AppTextStyle.eigStyle),
                  //   ),
                  //   const Expanded(child: Divider(color: greyColor)),]
                  // )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New to EduAgent? ', style: AppTextStyle.ninStyle),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Create an account',
                    style: AppTextStyle.tenStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
