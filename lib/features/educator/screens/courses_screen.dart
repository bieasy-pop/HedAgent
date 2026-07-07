import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/mock_data.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  void _openEnrollSheet() {
    final enrolledIds = EducatorMockStore.enrolledCourses.map((c) => c.id);
    final selectable = EducatorMockStore.availableCourses
        .where((c) => !enrolledIds.contains(c.id))
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enroll in a Course', style: AppTextStyle.fourtStyle),
              const Gap(16),
              if (selectable.isEmpty)
                Text(
                  "You're already in charge of every listed course.",
                  style: AppTextStyle.nintStyle,
                )
              else
                ...selectable.map(
                  (course) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(course.title, style: AppTextStyle.fourStyle),
                    subtitle: Text(
                      '${course.code} • ${course.studentCount} students',
                      style: AppTextStyle.eigStyle,
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        setState(() {
                          EducatorMockStore.enrolledCourses.add(course);
                        });
                        Navigator.of(sheetContext).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Enrolled as in-charge of ${course.code}.'),
                          ),
                        );
                      },
                      child: const Text('Enroll'),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final courses = EducatorMockStore.enrolledCourses;

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: _openEnrollSheet,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ]),
      body: courses.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0 / 390 * size.width,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "You're not in charge of any courses yet.",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.nintStyle,
                    ),
                    const Gap(12),
                    TextButton(
                      onPressed: _openEnrollSheet,
                      child: const Text('Enroll in a course'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0 / 390 * size.width,
                vertical: 16,
              ),
              itemCount: courses.length,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (context, index) {
                final course = courses[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: fourLightBlueColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.menu_book_outlined,
                          color: primaryColor,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(course.title, style: AppTextStyle.fourStyle),
                            Text(
                              '${course.code} • ${course.studentCount} students',
                              style: AppTextStyle.eigStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
