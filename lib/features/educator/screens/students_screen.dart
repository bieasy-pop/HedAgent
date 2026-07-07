import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/educator/data/mock_data.dart';
import 'package:hedagent/features/educator/screens/student_detail_screen.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  void _openAddStudentSheet() {
    final nameController = TextEditingController();
    final matricController = TextEditingController();
    final departmentController = TextEditingController();
    final levelController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Student', style: AppTextStyle.fourtStyle),
                const Gap(16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const Gap(12),
                TextFormField(
                  controller: matricController,
                  decoration: const InputDecoration(labelText: 'Matric no'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const Gap(12),
                TextFormField(
                  controller: departmentController,
                  decoration: const InputDecoration(labelText: 'Department'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const Gap(12),
                TextFormField(
                  controller: levelController,
                  decoration: const InputDecoration(labelText: 'Level'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const Gap(20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      setState(() {
                        EducatorMockStore.students.add(
                          MockStudent(
                            id: 's${EducatorMockStore.students.length + 1}',
                            name: nameController.text.trim(),
                            matricNo: matricController.text.trim(),
                            department: departmentController.text.trim(),
                            level: levelController.text.trim(),
                            riskLabel: 'On Track',
                            attendanceRate: 100,
                            gpa: 0,
                          ),
                        );
                      });
                      Navigator.of(sheetContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Student added.')),
                      );
                    },
                    child: Text(
                      'Add Student',
                      style: AppTextStyle.fivStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _riskColor(String riskLabel) {
    switch (riskLabel) {
      case 'At Risk':
        return redColor;
      case 'Warning':
        return const Color(0xFFB45309);
      default:
        return greenColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final students = EducatorMockStore.students;

    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: _openAddStudentSheet,
          icon: const Icon(Icons.person_add_alt_outlined),
        ),
      ]),
      body: students.isEmpty
          ? Center(
              child: Text('No students yet.', style: AppTextStyle.nintStyle),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0 / 390 * size.width,
                vertical: 16,
              ),
              itemCount: students.length,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (context, index) {
                final student = students[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            StudentDetailScreen(studentId: student.id),
                      ),
                    );
                  },
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
                              Text(student.name, style: AppTextStyle.fourStyle),
                              Text(
                                '${student.matricNo} • ${student.department} • ${student.level}L',
                                style: AppTextStyle.eigStyle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _riskColor(
                              student.riskLabel,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            student.riskLabel,
                            style: AppTextStyle.twelvStyle.copyWith(
                              color: _riskColor(student.riskLabel),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: greyColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
