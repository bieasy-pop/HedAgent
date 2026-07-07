class StudentProfile {
  const StudentProfile({
    this.studentNumber,
    this.faculty,
    this.department,
    this.programme,
    this.level,
    this.yearOfAdmission,
    this.expectedGraduation,
    this.gpa,
    this.attendanceRate,
    this.riskLabel,
  });

  final String? studentNumber;
  final String? faculty;
  final String? department;
  final String? programme;
  final String? level;
  final String? yearOfAdmission;
  final String? expectedGraduation;
  final num? gpa;
  final num? attendanceRate;
  final String? riskLabel;

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      studentNumber: json['student_number'] as String?,
      faculty: json['faculty'] as String?,
      department: json['department'] as String?,
      programme: json['programme'] as String?,
      level: json['level'] as String?,
      yearOfAdmission: json['year_of_admission'] as String?,
      expectedGraduation: json['expected_graduation'] as String?,
      gpa: json['gpa'] as num?,
      attendanceRate: json['attendance_rate'] as num?,
      riskLabel: json['risk_label'] as String?,
    );
  }
}

class EducatorProfile {
  const EducatorProfile({
    this.staffId,
    this.faculty,
    this.department,
    this.designation,
    this.specialization,
  });

  final String? staffId;
  final String? faculty;
  final String? department;
  final String? designation;
  final String? specialization;

  factory EducatorProfile.fromJson(Map<String, dynamic> json) {
    return EducatorProfile(
      staffId: json['staff_id'] as String?,
      faculty: json['faculty'] as String?,
      department: json['department'] as String?,
      designation: json['designation'] as String?,
      specialization: json['specialization'] as String?,
    );
  }
}

class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.otherName,
    this.fullName,
    this.universityName,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.avatarUrl,
    this.isActive = true,
    this.isVerified = false,
    this.studentProfile,
    this.educatorProfile,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? otherName;
  final String? fullName;
  final String? universityName;
  final String? phoneNumber;
  final String? gender;
  final String? dateOfBirth;
  final String role;
  final String? avatarUrl;
  final bool isActive;
  final bool isVerified;
  final StudentProfile? studentProfile;
  final EducatorProfile? educatorProfile;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id']?.toString() ?? '',
      email: json['email'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      otherName: json['other_name'] as String?,
      fullName: json['full_name'] as String?,
      universityName: json['university_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      role: json['role'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      isVerified: json['is_verified'] as bool? ?? false,
      studentProfile: json['student_profile'] == null
          ? null
          : StudentProfile.fromJson(
              json['student_profile'] as Map<String, dynamic>,
            ),
      educatorProfile: json['educator_profile'] == null
          ? null
          : EducatorProfile.fromJson(
              json['educator_profile'] as Map<String, dynamic>,
            ),
    );
  }
}

class AuthResponse {
  const AuthResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  final bool success;
  final String message;
  final String token;
  final AuthUser user;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      token: json['token'] as String? ?? '',
      user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
