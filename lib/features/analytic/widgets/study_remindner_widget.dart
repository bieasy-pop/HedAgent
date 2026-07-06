import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/texts.dart';

Widget studyReminderWidget({required Size size, required body}) {
  return SizedBox(
    height: 200,
    width: double.infinity,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.asset(
            ImagePath.studyCirclePicPath,
            fit: BoxFit.fill,
            height: 200,
            width: double.infinity,
          ),
          Positioned(
            top: 60,
            left: 32,
            child: SizedBox(
              width: 300 / 390 * size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Study Circles', style: AppTextStyle.twentFivStyle),
                  Text(softWrap: true, body, style: AppTextStyle.twentThrStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
