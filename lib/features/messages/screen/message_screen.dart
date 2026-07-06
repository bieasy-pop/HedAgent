import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/utils/information_util.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/messages/widgets/chat_container_widget.dart';
import 'package:hedagent/features/messages/widgets/inbox_agent_alert_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
              Gap(32 / 844 * size.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 300 / 390 * size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Texts.inboxText,
                          style: AppTextStyle.twentSixStyle,
                        ),
                        Text(
                          Texts.inboxSubtitle,
                          style: AppTextStyle.elevStyle,
                        ),
                      ],
                    ),
                  ),
                  Gap(8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      color: primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.note_alt_outlined,
                        size: 30,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(24 / 844 * size.height),
              Row(
                children: [
                  SvgPicture.asset(ImagePath.botIconPath),
                  Gap(20),
                  Text(Texts.agentIntelText, style: AppTextStyle.tenStyle),
                ],
              ),
              Gap(12 / 844 * size.height),
              inboxAgentAlertWidget(
                size: size,
                title: 'Agent Alert: Physics Study Update',
                status: 'Priority'.toUpperCase(),
                btnAction: () {},
                btnText: 'Review Material',
                body:
                    'New study material detected for Physics. Based on your exam schedule, I recommend reviewing the "Quantum Mechanics" module tonight',
              ),
              Gap(24 / 844 * size.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Texts.recConvText, style: AppTextStyle.elevStyle),
                  TextButton(onPressed: () {}, child: Text(Texts.seeMoreText)),
                ],
              ),
              Gap(16 / 844 * size.height),
              chatContainerWidget(
                size: size,
                receiver: 'Dr. Sarah Oni',
                time: '12:45 PM',
                body:
                    'Your thesis proposal looks promising. I\'ve left some notes on the draft.',
                area: 'Advanced Physics',
                isOnline: true,
                isRead: false,
              ),
              chatContainerWidget(
                size: size,
                receiver: 'Dr. Jenkins Oni',
                time: 'Yesterday',
                body:
                    'The registration deadline for the winter semester has been extended to Friday.',
                area: 'Advanced Physics',
                isOnline: false,
                isRead: true,
              ),
              chatContainerWidget(
                size: size,
                receiver: 'Dr. Jenkins Oni',
                time: 'Yesterday',
                body:
                    'Is everyone meeting at the lab at 4 or 5 today? The registration deadline for the winter semester has been extended to Friday.',
                area: 'Advanced Physics',
                isOnline: false,
                isRead: false,
              ),
              chatContainerWidget(
                size: size,
                receiver: 'Dr. Jenkins Oni',
                time: 'Yesterday',
                body:
                    'The registration deadline for the winter semester has been extended to Friday.',
                area: 'Advanced Physics',
                isOnline: true,
                isRead: true,
              ),
              Gap(24 / 844 * size.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Texts.recAlertsText, style: AppTextStyle.elevStyle),
                  TextButton(onPressed: () {}, child: Text(Texts.seeMoreText)),
                ],
              ),
              Gap(12 / 844 * size.height),
              alertContainerWidget(
                size: size,
                status: AlertStatus.minRisk,
                title: 'Exam Conflict Detected',
                body: 'Mathematics and Chem Lab overlap on Dec 12th.',
              ),
              Gap(8 / 844 * size.height),
              alertContainerWidget(
                size: size,
                status: AlertStatus.reminder,
                title: 'Class Canceled',
                body: 'Introduction to AI at 10 AM is canceled today.',
              ),
              Gap(8 / 844 * size.height),
              alertContainerWidget(
                size: size,
                status: AlertStatus.minRisk,
                title: 'Exam Conflict Detected',
                body: 'Mathematics and Chem Lab overlap on Dec 12th.',
              ),
              Gap(50 / 844 * size.height),
            ],
          ),
        ),
      ),
    );
  }
}

Widget alertContainerWidget({
  required Size size,
  required AlertStatus status,
  required String title,
  required String body,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
    decoration: BoxDecoration(
      color: lightBlueColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor:
              status == AlertStatus.maxRisk || status == AlertStatus.minRisk
              ? Color(0XFFFFDAD6)
              : status == AlertStatus.reminder
              ? Color(0XFFE0E3E5)
              : null,
          child: status == AlertStatus.maxRisk || status == AlertStatus.minRisk
              ? Icon(Icons.warning, color: redColor)
              : status == AlertStatus.intervention
              ? Icon(Icons.energy_savings_leaf)
              : status == AlertStatus.reminder
              ? Icon(Icons.access_time, color: thirGreyColor)
              : status == AlertStatus.normal
              ? Icon(Icons.align_vertical_top_outlined)
              : Icon(Icons.warning, color: redColor),
        ),
        Gap(16 / 390 * size.width),
        SizedBox(
          width: 0.65 * size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.fourStyle),
              Text(softWrap: true, body, style: AppTextStyle.sevStyle),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios_outlined, color: fourGreyColor),
      ],
    ),
  );
}
