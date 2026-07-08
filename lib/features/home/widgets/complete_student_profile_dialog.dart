import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/features/authentication/data/auth_repository.dart';
import 'package:hedagent/features/authentication/data/models/student_profile_request.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';

/// Blocking dialog shown to a signed-in student whose academic profile
/// (GPA, attendance rate, risk label) hasn't been classified yet. The
/// student must submit grade level, department, GPA, attendance rate,
/// and student number before the dashboard becomes usable.
///
/// Returns `true` once the profile has been completed and the cached
/// [AuthUser] has been refreshed with the backend's response.
Future<bool?> showCompleteStudentProfileDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const _CompleteStudentProfileDialog(),
  );
}

class _CompleteStudentProfileDialog extends StatefulWidget {
  const _CompleteStudentProfileDialog();

  @override
  State<_CompleteStudentProfileDialog> createState() =>
      _CompleteStudentProfileDialogState();
}

class _CompleteStudentProfileDialogState
    extends State<_CompleteStudentProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  final _gradeLevelController = TextEditingController();
  final _departmentController = TextEditingController();
  final _gpaController = TextEditingController();
  final _attendanceRateController = TextEditingController();
  final _studentNumberController = TextEditingController();

  bool _isSubmitting = false;
  bool _isPrefilling = true;
  String? _errorMessage;

  // Locked (read-only) once we already have the value from the profile
  // saved during sign up/sign in, so the student isn't asked to retype it.
  bool _departmentIsKnown = false;
  bool _studentNumberIsKnown = false;

  @override
  void initState() {
    super.initState();
    _prefillFromStoredProfile();
  }

  Future<void> _prefillFromStoredProfile() async {
    final user = await UserStorageService().getUser();
    final profile = user?.studentProfile;

    if (!mounted) return;
    setState(() {
      final department = profile?.department?.trim();
      if (department != null && department.isNotEmpty) {
        _departmentController.text = department;
        _departmentIsKnown = true;
      }

      final studentNumber = profile?.studentNumber?.trim();
      if (studentNumber != null && studentNumber.isNotEmpty) {
        _studentNumberController.text = studentNumber;
        _studentNumberIsKnown = true;
      }

      _isPrefilling = false;
    });
  }

  @override
  void dispose() {
    _gradeLevelController.dispose();
    _departmentController.dispose();
    _gpaController.dispose();
    _attendanceRateController.dispose();
    _studentNumberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final storage = UserStorageService();
      final token = await storage.getToken();
      final user = await storage.getUser();
      if (token == null || user == null) {
        throw AuthException('Session expired. Please log in again.');
      }

      final repository = AuthRepository();
      await repository.completeStudentProfile(
        token,
        user.id,
        StudentProfileRequest(
          gradeLevel: _gradeLevelController.text.trim(),
          department: _departmentController.text.trim(),
          gpa: num.parse(_gpaController.text.trim()),
          attendanceRate: num.parse(_attendanceRateController.text.trim()),
          studentNumber: _studentNumberController.text.trim(),
        ),
      );

      // Re-fetch the canonical profile rather than trusting the PATCH
      // response, so what's cached always matches the backend record.
      final refreshedProfile = await repository.getMyStudentProfile(token);
      await storage.saveUser(user.copyWith(studentProfile: refreshedProfile));

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on AuthException catch (e) {
      setState(() => _errorMessage = e.message);
    } catch (_) {
      setState(
        () => _errorMessage = 'Something went wrong. Please try again.',
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _isPrefilling
              ? const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Complete Your Profile', style: AppTextStyle.fourtStyle),
                  Gap(6),
                  Text(
                    'We need a few academic details to personalize your insights and track your progress.',
                    style: AppTextStyle.nintStyle,
                  ),
                  Gap(20),
                  TextFormField(
                    controller: _gradeLevelController,
                    decoration: const InputDecoration(labelText: 'Grade Level'),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Grade level is required'
                        : null,
                  ),
                  Gap(12),
                  TextFormField(
                    controller: _departmentController,
                    readOnly: _departmentIsKnown,
                    decoration: InputDecoration(
                      labelText: 'Department',
                      helperText: _departmentIsKnown
                          ? 'From your student profile'
                          : null,
                      filled: _departmentIsKnown,
                      fillColor: _departmentIsKnown
                          ? fourLightBlueColor
                          : null,
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Department is required'
                        : null,
                  ),
                  Gap(12),
                  TextFormField(
                    controller: _gpaController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(labelText: 'GPA'),
                    validator: (value) {
                      final parsed = num.tryParse((value ?? '').trim());
                      if (parsed == null) return 'Enter a valid GPA';
                      if (parsed < 0 || parsed > 5) {
                        return 'GPA should be between 0 and 5';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  TextFormField(
                    controller: _attendanceRateController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Attendance Rate (%)',
                    ),
                    validator: (value) {
                      final parsed = num.tryParse((value ?? '').trim());
                      if (parsed == null) return 'Enter a valid percentage';
                      if (parsed < 0 || parsed > 100) {
                        return 'Attendance rate should be between 0 and 100';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  TextFormField(
                    controller: _studentNumberController,
                    readOnly: _studentNumberIsKnown,
                    decoration: InputDecoration(
                      labelText: 'Student Number',
                      helperText: _studentNumberIsKnown
                          ? 'From your student profile'
                          : null,
                      filled: _studentNumberIsKnown,
                      fillColor: _studentNumberIsKnown
                          ? fourLightBlueColor
                          : null,
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                        ? 'Student number is required'
                        : null,
                  ),
                  if (_errorMessage != null) ...[
                    Gap(12),
                    Text(
                      _errorMessage!,
                      style: AppTextStyle.sevStyle.copyWith(color: redColor),
                    ),
                  ],
                  Gap(24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: whiteColor,
                              ),
                            )
                          : Text('Submit', style: AppTextStyle.fivStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
