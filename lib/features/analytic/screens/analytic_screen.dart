import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/analytic/widgets/course_highlight_widget.dart';
import 'package:hedagent/features/analytic/widgets/predicted_path_widget.dart';
import 'package:hedagent/features/analytic/widgets/study_remindner_widget.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(48 / 844 * size.height),
              Text(
                Texts.performanceAnalyticsText,
                style: AppTextStyle.twentStyle,
              ),
              Text(
                Texts.performanceAnalyticsSubtitle,
                style: AppTextStyle.nintStyle,
              ),
              Gap(40 / 844 * size.height),
              predictedPathWidget(
                size: size,
                subtitle:
                    'Trending Up: Your consistency in Biology is predicting a 94% final score.',
                firPoint: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(ImagePath.performanceIconPath),
                      Gap(2),
                      Text(
                        'On Track for Summa Cum Laude',
                        style: AppTextStyle.twelvStyle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                secPoint: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Est. GPA: 3.84',
                    style: AppTextStyle.twelvStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              Gap(40 / 844 * size.height),
              performanceTrendsWidget(size),
              Gap(40 / 844 * size.height),
              Text(Texts.courseBreakdownText, style: AppTextStyle.fourtStyle),
              Gap(12 / 844 * size.height),
              courseHighlightWidget(
                size: size,
                courseTitle: 'Open Source Development',
                grade: 75,
                lecturer: 'Dr. Falade Adeshola',
                performanceStatus: 80,
                improvementLevel: 5,
              ),
              Gap(12 / 844 * size.height),
              courseHighlightWidget(
                size: size,
                courseTitle: 'Distributed Systems',
                grade: 65,
                lecturer: 'Dr. Oyedele',
                performanceStatus: 60,
                improvementLevel: 15,
              ),
              Gap(12 / 844 * size.height),
              courseHighlightWidget(
                size: size,
                courseTitle: 'Modelling & Simulation',
                grade: 55,
                lecturer: 'Dr. Olaoye',
                performanceStatus: 45,
                improvementLevel: 10,
              ),
              Gap(40 / 844 * size.height),
              studyReminderWidget(
                size: size,
                body:
                    'Biology exam group meets tomorrow at 4PM in the Digital Lab.',
              ),
              Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
