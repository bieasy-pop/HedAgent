import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';

PreferredSizeWidget headerWidget(
  String logoPath,
  String brandName,
  List<Widget> actions,
) {
  return AppBar(
    title: Row(
      children: [
        SvgPicture.asset(
          colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
          ImagePath.smallIconPath,
          height: 19,
          width: 19,
        ),
        Gap(8),
        Text(Texts.appNameText, style: AppTextStyle.firStyle),
      ],
    ),
    actions: actions,
  );
}
