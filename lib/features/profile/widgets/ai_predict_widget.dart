import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/utils/information_util.dart';

Widget aiPredictedOutcomeWidget({
  required Size size,
  required BuildContext context,
  required int confidence,
  required String text,
}) {
  return Container(
    padding: EdgeInsets.all(16 / 844 * size.height),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: primaryColor, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Texts.aiPredInsightText, style: AppTextStyle.twelvStyle),
            SvgPicture.asset(ImagePath.aiIconPath),
          ],
        ),
        Text(Texts.predOutcomeText, style: AppTextStyle.fourtStyle),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(gradeConverter(confidence), style: AppTextStyle.fiftStyle),
            Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Texts.confidenceText, style: AppTextStyle.eigStyle),
                Text('$confidence%', style: AppTextStyle.sixtStyle),
                Gap(12 / 844 * size.height),
              ],
            ),
          ],
        ),
        LinearProgressIndicator(
          stopIndicatorRadius: 20,
          value: confidence / 100,
          minHeight: 9,
          color: primaryColor,
          backgroundColor: secLightBlueColor,
        ),
        Gap(12 / 844 * size.height),
        Container(
          padding: EdgeInsets.all(12 / 844 * size.height),
          decoration: BoxDecoration(
            color: thirLightBlueColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            textAlign: TextAlign.justify,
            text,
            style: AppTextStyle.sevtStyle,
          ),
        ),
      ],
    ),
  );
}
