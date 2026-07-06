import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';

Widget inboxAgentAlertWidget({
  required Size size,
  required String title,
  required String status,
  required String body,
  required String btnText,
  required dynamic btnAction,
}) {
  return Container(
    padding: EdgeInsets.all(16 / 844 * size.height),
    decoration: BoxDecoration(
      color: sixthLightBlueColor,
      gradient: LinearGradient(
        colors: [sixthLightBlueColor, whiteColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      border: Border.all(color: purpleColor),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: primaryColor,
          child: SvgPicture.asset(ImagePath.alertIconPath),
        ),
        Gap(16 / 390 * size.width),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 150 / 390 * size.width,
                  child: Text(
                    softWrap: true,
                    title,
                    style: AppTextStyle.fourStyle,
                  ),
                ),
                Gap(10 / 390 * size.width),
                Chip(label: Text('PRIORITY')),
              ],
            ),
            Gap(4),
            SizedBox(
              width: 250 / 390 * size.width,
              child: Text(softWrap: true, body),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Text(btnText, style: AppTextStyle.twentSevStyle),
                  Icon(Icons.arrow_forward, color: whiteColor),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
