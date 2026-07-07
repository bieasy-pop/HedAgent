import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/mock_data.dart';
import 'package:hedagent/features/profile/widgets/intervention_widget.dart';

class EducatorDashboardScreen extends StatelessWidget {
  const EducatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final students = EducatorMockStore.students;
    final atRiskCount = students
        .where((s) => s.riskLabel == 'At Risk' || s.riskLabel == 'Warning')
        .length;
    final avgAttendance = students.isEmpty
        ? 0.0
        : students.map((s) => s.attendanceRate).reduce((a, b) => a + b) /
              students.length;

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 / 390 * size.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(24 / 844 * size.height),
              Text('Overview', style: AppTextStyle.fourtStyle),
              Gap(16 / 844 * size.height),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  _InsightCard(
                    label: 'Students',
                    value: '${students.length}',
                    icon: Icons.groups_outlined,
                  ),
                  _InsightCard(
                    label: 'At Risk',
                    value: '$atRiskCount',
                    icon: Icons.warning_amber_outlined,
                    valueColor: redColor,
                  ),
                  _InsightCard(
                    label: 'Courses In Charge',
                    value: '${EducatorMockStore.enrolledCourses.length}',
                    icon: Icons.menu_book_outlined,
                  ),
                  _InsightCard(
                    label: 'Avg. Attendance',
                    value: '${avgAttendance.toStringAsFixed(0)}%',
                    icon: Icons.event_available_outlined,
                  ),
                ],
              ),
              Gap(32 / 844 * size.height),
              Text('Recent Interventions', style: AppTextStyle.fourtStyle),
              Gap(12 / 844 * size.height),
              if (EducatorMockStore.interventions.isEmpty)
                Text(
                  'No interventions logged yet.',
                  style: AppTextStyle.nintStyle,
                )
              else
                ...EducatorMockStore.interventions.map(
                  (intervention) => Padding(
                    padding: EdgeInsets.only(bottom: 6 / 844 * size.height),
                    child: iteractionWidget(
                      level: intervention.level,
                      size: size,
                      title: intervention.title,
                      time: intervention.time,
                      subtitle: intervention.subtitle,
                    ),
                  ),
                ),
              Gap(40 / 844 * size.height),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 20),
          const Gap(8),
          Text(
            value,
            style: AppTextStyle.fourtStyle.copyWith(
              color: valueColor ?? darkBlueColor,
            ),
          ),
          Text(label, style: AppTextStyle.eigStyle),
        ],
      ),
    );
  }
}
