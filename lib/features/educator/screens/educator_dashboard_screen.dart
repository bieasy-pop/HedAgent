import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/educator_store.dart';
import 'package:hedagent/features/educator/widgets/stat_card_widget.dart';
import 'package:hedagent/features/educator/widgets/student_tile_widget.dart';
import 'package:hedagent/route/app_router_names.dart';

class EducatorDashboardScreen extends StatelessWidget {
  const EducatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final store = EducatorStore.instance;

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: () => context.pushNamed(RouteNames.sendAlertScreenString),
          icon: const Icon(Icons.notifications_none_outlined),
        ),
      ]),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final atRisk = store.studentsAtRisk();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(32 / 844 * size.height),
                  Text('Educator Overview', style: AppTextStyle.twentStyle),
                  Text(
                    'Track your students and take action before they fall behind.',
                    style: AppTextStyle.nintStyle,
                  ),
                  Gap(24 / 844 * size.height),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      statCardWidget(
                        size: size,
                        icon: Icons.groups_outlined,
                        iconColor: primaryColor,
                        iconBgColor: fourLightBlueColor,
                        label: 'Total Students',
                        value: '${store.students.length}',
                      ),
                      statCardWidget(
                        size: size,
                        icon: Icons.menu_book_outlined,
                        iconColor: purpleColor,
                        iconBgColor: firLightPurpleColor,
                        label: 'Courses in Charge',
                        value: '${store.enrolledCourseCount}',
                      ),
                      statCardWidget(
                        size: size,
                        icon: Icons.warning_amber_outlined,
                        iconColor: redColor,
                        iconBgColor: lightRedColor,
                        label: 'At-Risk Students',
                        value: '${store.atRiskCount}',
                      ),
                      statCardWidget(
                        size: size,
                        icon: Icons.energy_savings_leaf_outlined,
                        iconColor: greenColor,
                        iconBgColor: Color(0XFFDCFCE7),
                        label: 'Interventions Logged',
                        value: '${store.interventionCount}',
                      ),
                    ],
                  ),
                  Gap(32 / 844 * size.height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Students Needing Attention',
                        style: AppTextStyle.fourtStyle.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  Gap(12 / 844 * size.height),
                  if (atRisk.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'No students currently need intervention. Great work!',
                        style: AppTextStyle.nintStyle,
                      ),
                    )
                  else
                    ...atRisk.map(
                      (student) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: studentTileWidget(
                          size: size,
                          student: student,
                          onTap: () => context.pushNamed(
                            RouteNames.studentDetailScreenString,
                            extra: student,
                          ),
                        ),
                      ),
                    ),
                  Gap(24 / 844 * size.height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Courses In Charge',
                        style: AppTextStyle.fourtStyle.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  Gap(12 / 844 * size.height),
                  ...store.enrolledCourses.map(
                    (course) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.title,
                                    style: AppTextStyle.fourStyle,
                                  ),
                                  Text(
                                    '${course.code} • ${store.studentsInCourse(course.title).length} students',
                                    style: AppTextStyle.nintStyle,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: fourGreyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
