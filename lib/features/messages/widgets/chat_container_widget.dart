import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';

Widget chatContainerWidget({
  required Size size,
  required String receiver,
  required String time,
  required String body,
  required String area,
  required bool isOnline,
  required bool isRead,
}) {
  return Container(
    height: 151 / 844 * size.height,
    padding: EdgeInsets.only(right: 12),
    width: double.infinity,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !isRead
            ? VerticalDivider(
                radius: BorderRadius.circular(24),
                thickness: 5,
                color: primaryColor,
              )
            : Gap(12 / 390 * size.width),
        Gap(12 / 390 * size.width),
        Badge(
          alignment: Alignment.bottomRight,
          isLabelVisible: isOnline,
          backgroundColor: greenColor,
          smallSize: 12,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(66),
            child: Image.asset(
              ImagePath.studentPicPath,
              fit: BoxFit.cover,
              height: 70,
              width: 70,
            ),
          ),
        ),
        Gap(16 / 390 * size.width),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(receiver, style: AppTextStyle.thirStyle),
                    Gap(50 / 390 * size.width),
                    Text(
                      time,
                      style: isRead
                          ? AppTextStyle.nintStyle
                          : AppTextStyle.twelvStyle,
                    ),
                  ],
                ),
                Text(
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  body,
                  style: isRead
                      ? AppTextStyle.nintStyle
                      : AppTextStyle.thirStyle,
                ),
                Gap(12),
                Row(
                  children: [
                    isRead
                        ? Icon(Icons.check_sharp, color: secGreyColor)
                        : Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: fourGreyColor,
                            ),
                          ),
                    Gap(8),
                    isRead
                        ? Text('Read', style: AppTextStyle.nintStyle)
                        : Text(area, style: AppTextStyle.twentEigStyle),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
