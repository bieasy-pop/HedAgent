import 'package:flutter/material.dart'
    show TextStyle, FontWeight, ThemeData, Brightness, ColorScheme;
import 'package:hedagent/constants/colors.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: secondaryColor,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
);

class AppTextStyle {
  static TextStyle firStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );
  static TextStyle secStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );
  static TextStyle thirStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: darkBlueColor,
  );
  static TextStyle fourStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: darkBlueColor,
  );
  static TextStyle fivStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: whiteColor,
  );
  static TextStyle sixStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: secGreyColor,
  );
  static TextStyle sevStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: secGreyColor,
  );
  static TextStyle eigStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: secGreyColor,
  );
  static TextStyle ninStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: blackColor,
  );
  static TextStyle tenStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryColor,
  );
  static TextStyle elevStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: secGreyColor,
  );
  static TextStyle twelvStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );
  static TextStyle thirtStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: lightPurpleColor,
  );
  static TextStyle fourtStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: darkBlueColor,
  );
  static TextStyle fiftStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );
  static TextStyle sixtStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );
  static TextStyle sevtStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: blackColor,
  );
  static TextStyle eigtStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: greenColor,
  );
  static TextStyle nintStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: secGreyColor,
  );
  static TextStyle twentStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: darkBlueColor,
  );
  static TextStyle twentOneStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: purpleColor,
  );
  static TextStyle twentTwoStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: darkBlueColor,
  );
  static TextStyle twentThrStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: whiteColor,
  );
  static TextStyle twentFourStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );
  static TextStyle twentFivStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: whiteColor,
  );
  static TextStyle twentSixStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: darkBlueColor,
  );
  static TextStyle twentSevStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: whiteColor,
  );
  static TextStyle twentEigStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: fourGreyColor,
  );
}
