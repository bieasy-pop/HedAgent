import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';

Widget onboardingWidget({
  required BuildContext context,
  required Size size,
  required Widget pageIcon,
  required String text,
  required String subtitle,
  required Widget firstPointIcon,
  required Widget secondPointIcon,
  required String firstPoint,
  required String secondPoint,
}) {
  return Column(
    children: [
      Gap(80 / 884 * size.height),
      pageIcon,
      Gap(40 / 884 * size.height),
      Text(textAlign: TextAlign.center, text, style: AppTextStyle.secStyle),
      Gap(30 / 884 * size.height),
      Text(
        textAlign: TextAlign.center,
        subtitle,
        style: AppTextStyle.thirStyle,
      ),
      Gap(40 / 884 * size.height),
      onboardingInfoBloc(size, firstPointIcon, firstPoint),
      // firstPointIcon,
      Gap(8),
      onboardingInfoBloc(size, secondPointIcon, secondPoint),
      // secondPointIcon,
    ],
  );
}

Widget onboardingInfoBloc(Size size, Widget icon, String text) {
  return Container(
    padding: EdgeInsets.all(12),
    height: 44 / 844 * size.height,
    width: double.infinity,
    decoration: BoxDecoration(color: lightBlueColor),
    child: Row(
      children: [
        icon,
        Gap(8),
        Text(text, style: AppTextStyle.fourStyle),
      ],
    ),
  );
}
