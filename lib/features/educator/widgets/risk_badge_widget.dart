import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';

Color riskColor(String riskLabel) {
  switch (riskLabel) {
    case 'At Risk':
      return redColor;
    case 'Watch':
      return Color(0XFFB45309);
    default:
      return greenColor;
  }
}

Color riskBgColor(String riskLabel) {
  switch (riskLabel) {
    case 'At Risk':
      return lightRedColor;
    case 'Watch':
      return Color(0XFFFEF3C7);
    default:
      return Color(0XFFDCFCE7);
  }
}

Widget riskBadgeWidget(String riskLabel) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: riskBgColor(riskLabel),
      borderRadius: BorderRadius.circular(9999),
    ),
    child: Text(
      riskLabel,
      style: AppTextStyle.eigStyle.copyWith(color: riskColor(riskLabel)),
    ),
  );
}
