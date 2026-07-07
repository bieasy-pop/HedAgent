import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/widgets/elev_btn_widget.dart';
import 'package:hedagent/features/educator/data/mock_data.dart';
import 'package:hedagent/features/profile/widgets/intervention_widget.dart';

class StudentDetailScreen extends StatefulWidget {
  const StudentDetailScreen({super.key, required this.studentId});

  final String studentId;

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  MockStudent get _student => EducatorMockStore.students.firstWhere(
    (s) => s.id == widget.studentId,
  );

  List<MockIntervention> get _interventions => EducatorMockStore
      .interventions
      .where((i) => i.studentId == widget.studentId)
      .toList();

  void _logIntervention() {
    final titleController = TextEditingController();
    final notesController = TextEditingController();
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
                Text('Log Intervention', style: AppTextStyle.fourtStyle),
                const Gap(16),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const Gap(12),
                TextFormField(
                  controller: notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Notes'),
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
                        EducatorMockStore.interventions.add(
                          MockIntervention(
                            studentId: widget.studentId,
                            title: titleController.text.trim(),
                            subtitle: notesController.text.trim(),
                            time: 'Just now',
                            level: 2,
                          ),
                        );
                      });
                      Navigator.of(sheetContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Intervention logged.')),
                      );
                    },
                    child: Text('Save', style: AppTextStyle.fivStyle),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _sendAlert() {
    final messageController = TextEditingController();
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
                Text('Send Alert to ${_student.name}', style: AppTextStyle.fourtStyle),
                const Gap(16),
                TextFormField(
                  controller: messageController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Message'),
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
                      EducatorMockStore.alerts.add(
                        MockAlert(
                          id: 'a${EducatorMockStore.alerts.length + 1}',
                          title: 'Alert to ${_student.name}',
                          message: messageController.text.trim(),
                          target: _student.name,
                          sentAt: DateTime.now(),
                        ),
                      );
                      Navigator.of(sheetContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Alert sent to ${_student.name}.')),
                      );
                    },
                    child: Text('Send', style: AppTextStyle.fivStyle),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final student = _student;

    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 / 390 * size.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.name, style: AppTextStyle.fourtStyle),
                    Text(
                      '${student.matricNo} • ${student.department} • ${student.level}L',
                      style: AppTextStyle.eigStyle,
                    ),
                    const Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Attendance: ${student.attendanceRate.toStringAsFixed(0)}%',
                          style: AppTextStyle.sevStyle,
                        ),
                        Text(
                          'GPA: ${student.gpa.toStringAsFixed(2)}',
                          style: AppTextStyle.sevStyle,
                        ),
                        Text(
                          student.riskLabel,
                          style: AppTextStyle.twelvStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(20 / 844 * size.height),
              Row(
                children: [
                  Expanded(
                    child: elevBtn(
                      size,
                      _sendAlert,
                      'Send Alert',
                      null,
                      null,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: elevBtn(
                      size,
                      _logIntervention,
                      'Log Intervention',
                      secondaryColor,
                      AppTextStyle.tenStyle,
                    ),
                  ),
                ],
              ),
              Gap(32 / 844 * size.height),
              Text('Intervention History', style: AppTextStyle.fourtStyle),
              Gap(12 / 844 * size.height),
              if (_interventions.isEmpty)
                Text(
                  'No interventions logged for this student yet.',
                  style: AppTextStyle.nintStyle,
                )
              else
                ..._interventions.map(
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
