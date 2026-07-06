import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';

Widget iteractionWidget({
  required Size size,
  required int level,
  required String title,
  required String time,
  required String subtitle,
}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: level == 1 || level == 2
                ? fourLightBlueColor
                : level == 3 || level == 4
                ? lightRedColor
                : fourLightBlueColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            level == 1
                ? ImagePath.resourceSharedIconPath
                : level == 2
                ? ImagePath.recommendSharedIconPath
                : level == 3 || level == 4
                ? ImagePath.warningSharedIconPath
                : ImagePath.recommendSharedIconPath,
          ),
        ),
        Gap(16),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: AppTextStyle.fourStyle),
                  Gap(90 / 390 * size.width),
                  Text(time, style: AppTextStyle.elevStyle),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(subtitle, style: AppTextStyle.nintStyle),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
