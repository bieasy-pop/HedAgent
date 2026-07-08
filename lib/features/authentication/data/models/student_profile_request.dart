/// Body for the `PATCH` request that completes/updates a student's
/// academic profile (grade level, department, GPA, attendance rate).
class StudentProfileRequest {
  const StudentProfileRequest({
    required this.gradeLevel,
    required this.department,
    required this.gpa,
    required this.attendanceRate,
    required this.studentNumber,
    this.meta,
  });

  final String gradeLevel;
  final String department;
  final num gpa;
  final num attendanceRate;
  final String studentNumber;
  final Map<String, dynamic>? meta;

  Map<String, dynamic> toJson() => {
    'grade_level': gradeLevel,
    'department': department,
    'gpa': gpa,
    'attendance_rate': attendanceRate,
    'student_number': studentNumber,
    'meta': meta ?? <String, dynamic>{},
  };
}
