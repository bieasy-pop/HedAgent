import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';

Widget elevBtn(
  Size size,
  dynamic onPressed,
  String text,
  Color? bgColor,
  TextStyle? textStyle, [
  Widget? rowItem,
]) {
  return SizedBox(
    width: double.infinity,
    height: size.height * 60 / 852,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: rowItem ?? Text(text, style: textStyle ?? AppTextStyle.fivStyle),
    ),
  );
}
