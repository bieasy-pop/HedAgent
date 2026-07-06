import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/utils/information_util.dart';
import 'package:hedagent/constants/widgets/grade_container_widget.dart';

Widget courseHighlightWidget({
  required Size size,
  required String courseTitle,
  required num grade,
  required String lecturer,
  required num performanceStatus,
  required num improvementLevel,
}) {
  final String convertedGrade = gradeConverter(grade);
  return Card(
    color: whiteColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
      elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(courseTitle, style: AppTextStyle.twentFourStyle),
                  Text(lecturer, style: AppTextStyle.elevStyle),
                ],
              ),
              gradeContainerWidget(convertedGrade),
            ],
          ),
          Gap(70 / 844 * size.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Performance Analysis: $performanceStatus%',
                style: AppTextStyle.eigStyle,
              ),
              Row(
                children: [
                  improvementLevel < 0
                      ? Icon(Icons.arrow_downward, size: 12)
                      : improvementLevel == 0
                      ? Icon(Icons.arrow_forward, size: 12)
                      : Icon(Icons.arrow_upward, size: 12),
                  Text('$improvementLevel%'),
                ],
              ),
            ],
          ),
          LinearProgressIndicator(value: performanceStatus / 100),
        ],
      ),
    ),
  );
}
