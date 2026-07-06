import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/utils/information_util.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/profile/widgets/ai_predict_widget.dart';
import 'package:hedagent/features/profile/widgets/intervention_widget.dart';
import 'package:hedagent/features/profile/widgets/profile_activity_widget.dart';
import 'package:hedagent/features/profile/widgets/user_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
          padding: EdgeInsets.symmetric(horizontal: 20.0 / 844 * size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(36 / 844 * size.height),
              Center(
                child: userContainerWidget(
                  name: 'Elena Rodriguez',
                  picPath: ImagePath.studentPicPath,
                  level: 400,
                  department: 'Computer Science',
                  cgpa: 3.75,
                ),
              ),
              Gap(40 / 844 * size.height),
              aiPredictedOutcomeWidget(
                size: size,
                context: context,
                confidence: 85,
                text:
                    'Based on your current academic performance and engagement, you are on track to achieve a strong final grade in your courses.',
              ),
              Gap(40 / 844 * size.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  profileActivityContainer(
                    size: size,
                    text: Texts.attendanceText,
                    report: '94%',
                    status: Row(
                      children: [
                        Icon(Icons.arrow_upward, color: greenColor, size: 16),
                        Gap(4),
                        Text('2% vs last term', style: AppTextStyle.eigtStyle),
                      ],
                    ),
                  ),
                  profileActivityContainer(
                    size: size,
                    text: Texts.activityRepText,
                    report: '12/12',
                    status: Row(
                      children: [
                        Icon(Icons.check_circle, color: primaryColor, size: 16),
                        Gap(4),
                        Text('All on time', style: AppTextStyle.twelvStyle),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(40 / 844 * size.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Texts.interHistoryText, style: AppTextStyle.fourtStyle),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('View All', style: AppTextStyle.tenStyle),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              Gap(12 / 844 * size.height),
              iteractionWidget(
                level: interventionLevel(InterventionStatus.resource),
                size: size,
                title: 'Resource Shared',
                time: 'June 9',
                subtitle:
                    'Recommended "Dynamic Programming Essentials" via AI Nudge.',
              ),
              Gap(6 / 844 * size.height),
              iteractionWidget(
                level: interventionLevel(InterventionStatus.warning),
                size: size,
                title: 'Early Warning Sent',
                time: 'May 7',
                subtitle: 'Automated nudge sent after missed quiz in Week 2.',
              ),
              Gap(6 / 844 * size.height),
              iteractionWidget(
                level: interventionLevel(InterventionStatus.recommended),
                size: size,
                title: 'Office Hours Meeting',
                time: 'June 9',
                subtitle:
                    'Discussed thesis proposal. Student is ahead of schedule.',
              ),
              Gap(70),
            ],
          ),
        ),
      ),
    );
  }
}
