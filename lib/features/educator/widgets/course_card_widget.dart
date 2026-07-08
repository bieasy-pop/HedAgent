import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/features/educator/models/educator_models.dart';

Widget courseCardWidget({
  required Size size,
  required EducatorCourse course,
  required int studentCount,
  required VoidCallback onToggleEnrollment,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12),
      border: course.isEnrolled ? Border.all(color: primaryColor) : null,
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.title, style: AppTextStyle.fourStyle),
              Text(course.code, style: AppTextStyle.nintStyle),
              Gap(4),
              Row(
                children: [
                  Icon(Icons.groups_outlined, size: 14, color: fourGreyColor),
                  Gap(4),
                  Text('$studentCount students', style: AppTextStyle.eigStyle),
                ],
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: onToggleEnrollment,
          style: OutlinedButton.styleFrom(
            backgroundColor: course.isEnrolled ? primaryColor : whiteColor,
            side: BorderSide(color: primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            course.isEnrolled ? 'In Charge' : 'Enroll',
            style: AppTextStyle.tenStyle.copyWith(
              color: course.isEnrolled ? whiteColor : primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
