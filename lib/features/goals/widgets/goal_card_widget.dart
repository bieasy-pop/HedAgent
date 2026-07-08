import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/features/goals/models/goal.dart';

Widget goalCardWidget({
  required Size size,
  required Goal goal,
  required VoidCallback onTap,
}) {
  final aiSummary = goal.aiSummary;

  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  goal.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.fourStyle,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 12, color: fourGreyColor),
            ],
          ),
          if (aiSummary != null && aiSummary.isNotEmpty) ...[
            Gap(8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: thirLightBlueColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.auto_awesome, size: 14, color: primaryColor),
                  Gap(6),
                  Expanded(
                    child: Text(
                      aiSummary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.sevStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Gap(8),
          Row(
            children: [
              Icon(Icons.energy_savings_leaf, size: 14, color: fourGreyColor),
              Gap(4),
              Text(
                '${goal.interventions.length} intervention${goal.interventions.length == 1 ? '' : 's'}',
                style: AppTextStyle.eigStyle,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
