import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';

Widget statCardWidget({
  required Size size,
  required IconData icon,
  required Color iconColor,
  required Color iconBgColor,
  required String label,
  required String value,
}) {
  return Container(
    width: 168 / 390 * size.width,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 36,
          width: 36,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        Gap(12),
        Text(value, style: AppTextStyle.fourtStyle),
        Text(label, style: AppTextStyle.eigStyle),
      ],
    ),
  );
}
