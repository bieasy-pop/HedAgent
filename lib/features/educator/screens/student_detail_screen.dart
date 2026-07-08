import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/constants/utils/information_util.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';
import 'package:hedagent/features/authentication/data/auth_repository.dart';
import 'package:hedagent/features/authentication/data/models/auth_response.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';
import 'package:hedagent/features/educator/data/educator_store.dart';
import 'package:hedagent/features/educator/models/educator_models.dart';
import 'package:hedagent/features/educator/widgets/risk_badge_widget.dart';
import 'package:hedagent/features/profile/widgets/intervention_widget.dart';
import 'package:hedagent/route/app_router_names.dart';
import 'package:intl/intl.dart';

class StudentDetailScreen extends StatefulWidget {
  const StudentDetailScreen({super.key, required this.student});

  final EducatorStudent student;

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  StudentProfile? _liveProfile;

  @override
  void initState() {
    super.initState();
    _loadLiveProfile();
  }

  /// Refreshes GPA/attendance/risk data from the backend record for this
  /// student. Falls back silently to the locally tracked values if the
  /// lookup fails (e.g. a mock student not yet present on the backend).
  Future<void> _loadLiveProfile() async {
    try {
      final token = await UserStorageService().getToken();
      if (token == null) return;
      final profile = await AuthRepository().getStudentById(
        token,
        widget.student.id,
      );
      if (mounted) setState(() => _liveProfile = profile);
    } catch (_) {
      // Keep showing the locally tracked data.
    }
  }

  num get _gpa => _liveProfile?.gpa ?? widget.student.gpa;
  num get _attendanceRate =>
      _liveProfile?.attendanceRate ?? widget.student.attendanceRate;
  String get _riskLabel => _liveProfile?.riskLabel ?? widget.student.riskLabel;

  void _showLogInterventionSheet(BuildContext context) {
    final titleController = TextEditingController();
    final noteController = TextEditingController();
    InterventionStatus status = InterventionStatus.recommended;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Log Intervention', style: AppTextStyle.fourtStyle),
                  Gap(16),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Notes'),
                  ),
                  Gap(12),
                  DropdownButtonFormField<InterventionStatus>(
                    initialValue: status,
                    decoration: const InputDecoration(labelText: 'Severity'),
                    items: InterventionStatus.values
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setSheetState(() => status = value);
                      }
                    },
                  ),
                  Gap(20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (titleController.text.trim().isEmpty) return;
                        EducatorStore.instance.logIntervention(
                          widget.student,
                          InterventionRecord(
                            title: titleController.text.trim(),
                            time: DateFormat('MMM d').format(DateTime.now()),
                            subtitle: noteController.text.trim(),
                            status: status,
                          ),
                        );
                        Navigator.of(sheetContext).pop();
                      },
                      child: Text(
                        'Save Intervention',
                        style: AppTextStyle.fivStyle,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final student = widget.student;
    final aiSummary = _liveProfile?.aiSummary;

    return Scaffold(
      appBar: headerWidget('assets/svgs/small_ic.svg', 'EduAgent', []),
      body: ListenableBuilder(
        listenable: EducatorStore.instance,
        builder: (context, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(16),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: Image.asset(
                          student.picPath,
                          height: 72,
                          width: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(student.name, style: AppTextStyle.twentStyle),
                            Text(
                              '${student.level}L • ${student.department}',
                              style: AppTextStyle.nintStyle,
                            ),
                            Gap(6),
                            riskBadgeWidget(_riskLabel),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('GPA', style: AppTextStyle.eigStyle),
                              Text(
                                _gpa.toStringAsFixed(2),
                                style: AppTextStyle.fourtStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Attendance', style: AppTextStyle.eigStyle),
                              Text(
                                '$_attendanceRate%',
                                style: AppTextStyle.fourtStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (aiSummary != null && aiSummary.isNotEmpty) ...[
                    Gap(16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: thirLightBlueColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI PREDICTIVE INSIGHT',
                            style: AppTextStyle.eigStyle,
                          ),
                          Gap(4),
                          Text(aiSummary, style: AppTextStyle.sevtStyle),
                        ],
                      ),
                    ),
                  ],
                  Gap(24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => context.pushNamed(
                            RouteNames.sendAlertScreenString,
                            extra: student,
                          ),
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: whiteColor,
                          ),
                          label: Text(
                            'Send Alert',
                            style: AppTextStyle.fivStyle,
                          ),
                        ),
                      ),
                      Gap(12),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => _showLogInterventionSheet(context),
                          icon: Icon(Icons.add_task, color: primaryColor),
                          label: Text(
                            'Log Intervention',
                            style: AppTextStyle.tenStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(28),
                  Text('Intervention History', style: AppTextStyle.fourtStyle),
                  Gap(12),
                  if (student.interventions.isEmpty)
                    Text(
                      'No interventions logged yet.',
                      style: AppTextStyle.nintStyle,
                    )
                  else
                    ...student.interventions.map(
                      (record) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: iteractionWidget(
                          size: size,
                          level: interventionLevel(record.status),
                          title: record.title,
                          time: record.time,
                          subtitle: record.subtitle,
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
