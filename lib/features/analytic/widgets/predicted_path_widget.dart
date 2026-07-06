import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/message_chip_widget.dart';

Widget predictedPathWidget({
  required Size size,
  required String subtitle,
  required Widget firPoint,
  required Widget secPoint,
}) {
  return Container(
    padding: EdgeInsets.all(24 / 844 * size.height),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: primaryColor, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            ImagePath.smartIconPath,
            height: 65 / 844 * size.height,
            width: 65 / 844 * size.height,
          ),
        ),
        Text(Texts.predPathText, style: AppTextStyle.twentOneStyle),
        Text(subtitle, style: AppTextStyle.twentTwoStyle),
        Gap(8 / 844 * size.height),
        messageChip(color: fifthLightBlueColor, body: firPoint),
        Gap(8 / 844 * size.height),
        messageChip(color: firLightPurpleColor, body: secPoint),
        Gap(16 / 844 * size.height),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(Texts.genPlanText, style: AppTextStyle.twentThrStyle),
          ),
        ),
      ],
    ),
  );
}

Widget performanceTrendsWidget(Size size) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: whiteColor,
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Texts.perfTrendText.toUpperCase(),
            style: AppTextStyle.elevStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 212 / 390 * size.width,
                child: Text(
                  Texts.invTimeFrameText,
                  style: AppTextStyle.fourtStyle,
                ),
              ),
              Gap(8),
              Container(
                height: 12,
                width: 6,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Gap(12),
              Expanded(
                child: Text('2024 Semester 2', style: AppTextStyle.eigStyle),
              ),
            ],
          ),
          Gap(24 / 844 * size.height),
          Image.asset(
            ImagePath.chartSampleIconPath,
            height: 300,
            width: 300,
            fit: BoxFit.fill,
          ),
        ],
      ),
    ),
  );
}
