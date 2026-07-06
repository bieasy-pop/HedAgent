import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';

Widget userContainerWidget({
  required String name,
  required String picPath,
  required int level,
  required String department,
  required double cgpa,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(9999),
        child: Image.asset(picPath, fit: BoxFit.contain),
      ),
      Text(name, style: AppTextStyle.secStyle),
      Gap(4),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${level}L • $department • CGPA: ${cgpa.toStringAsFixed(2)}',
            style: AppTextStyle.elevStyle,
          ),
        ],
      ),
      Gap(12),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: secLightBlueColor,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text('Class of 2024', style: AppTextStyle.twelvStyle),
          ),
          Gap(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: lightPinkColor,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text('Subscribed', style: AppTextStyle.thirtStyle),
          ),
        ],
      ),
    ],
  );
}
