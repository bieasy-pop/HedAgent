import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/features/educator/models/educator_models.dart';
import 'package:hedagent/features/educator/widgets/risk_badge_widget.dart';

Widget studentTileWidget({
  required Size size,
  required EducatorStudent student,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: Image.asset(
              student.picPath,
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
          ),
          Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student.name, style: AppTextStyle.fourStyle),
                Text(
                  '${student.level}L • ${student.course}',
                  style: AppTextStyle.nintStyle,
                ),
              ],
            ),
          ),
          riskBadgeWidget(student.riskLabel),
          Gap(4),
          Icon(Icons.arrow_forward_ios, size: 12, color: fourGreyColor),
        ],
      ),
    ),
  );
}
