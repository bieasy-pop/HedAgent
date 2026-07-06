import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';

Widget profileActivityContainer({
  required Size size,
  required String text,
  required String report,
  required Widget status,
}) {
  return Container(
    width: 157 / 390 * size.width,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: AppTextStyle.eigStyle),
        Text(report, style: AppTextStyle.fourtStyle),
        status,
      ],
    ),
  );
}
