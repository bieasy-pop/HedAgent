import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';

Widget gradeContainerWidget(String grade) {
  return Container(
    // height: 32,
    decoration: BoxDecoration(
      color: sixthLightBlueColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(grade, style: AppTextStyle.firStyle),
    ),
  );
}
