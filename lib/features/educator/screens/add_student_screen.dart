import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/educator_store.dart';
import 'package:hedagent/features/educator/models/educator_models.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _levelController = TextEditingController();
  String? _selectedCourse;

  @override
  void dispose() {
    _nameController.dispose();
    _departmentController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final courses = EducatorStore.instance.enrolledCourses;

    return Scaffold(
      appBar: headerWidget('assets/svgs/small_ic.svg', 'EduAgent', []),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(24),
                Text('Add Student', style: AppTextStyle.twentSixStyle),
                Text(
                  'Enroll a new student under one of your courses.',
                  style: AppTextStyle.elevStyle,
                ),
                Gap(24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                      ? 'Full name is required'
                      : null,
                ),
                Gap(12),
                TextFormField(
                  controller: _departmentController,
                  decoration: const InputDecoration(labelText: 'Department'),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                      ? 'Department is required'
                      : null,
                ),
                Gap(12),
                TextFormField(
                  controller: _levelController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Level'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Level is required';
                    }
                    if (int.tryParse(value.trim()) == null) {
                      return 'Enter a valid level, e.g. 300';
                    }
                    return null;
                  },
                ),
                Gap(12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCourse,
                  decoration: const InputDecoration(labelText: 'Course'),
                  items: courses
                      .map(
                        (course) => DropdownMenuItem(
                          value: course.title,
                          child: Text(course.title),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedCourse = value),
                  validator: (value) =>
                      value == null ? 'Select a course' : null,
                ),
                Gap(28),
                elevBtn(size, () {
                  if (!_formKey.currentState!.validate()) return;
                  EducatorStore.instance.addStudent(
                    EducatorStudent(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      name: _nameController.text.trim(),
                      picPath: 'assets/images/student_pic.png',
                      department: _departmentController.text.trim(),
                      level: int.parse(_levelController.text.trim()),
                      course: _selectedCourse!,
                      gpa: 0,
                      attendanceRate: 0,
                      riskLabel: 'On Track',
                    ),
                  );
                  context.pop();
                }, 'Add Student', primaryColor, null, null),
                Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
