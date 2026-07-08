import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/educator_store.dart';
import 'package:hedagent/features/educator/widgets/course_card_widget.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final store = EducatorStore.instance;

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, []),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(32 / 844 * size.height),
                  Text('Courses', style: AppTextStyle.twentSixStyle),
                  Text(
                    'Enroll as the educator in charge of a course to manage its students.',
                    style: AppTextStyle.elevStyle,
                  ),
                  Gap(20 / 844 * size.height),
                  ...store.courses.map(
                    (course) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: courseCardWidget(
                        size: size,
                        course: course,
                        studentCount: store
                            .studentsInCourse(course.title)
                            .length,
                        onToggleEnrollment: () =>
                            store.toggleEnrollment(course),
                      ),
                    ),
                  ),
                  Gap(70),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
