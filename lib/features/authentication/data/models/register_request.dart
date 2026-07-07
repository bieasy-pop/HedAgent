class StudentData {
  const StudentData({
    required this.studentNumber,
    required this.faculty,
    required this.department,
    required this.programme,
    required this.level,
    required this.yearOfAdmission,
    required this.expectedGraduation,
  });

  final String studentNumber;
  final String faculty;
  final String department;
  final String programme;
  final String level;
  final String yearOfAdmission;
  final String expectedGraduation;

  Map<String, dynamic> toJson() => {
    'student_number': studentNumber,
    'faculty': faculty,
    'department': department,
    'programme': programme,
    'level': level,
    'year_of_admission': yearOfAdmission,
    'expected_graduation': expectedGraduation,
  };
}

class EducatorData {
  const EducatorData({
    required this.staffId,
    required this.faculty,
    required this.department,
    required this.designation,
    required this.specialization,
  });

  final String staffId;
  final String faculty;
  final String department;
  final String designation;
  final String specialization;

  Map<String, dynamic> toJson() => {
    'staff_id': staffId,
    'faculty': faculty,
    'department': department,
    'designation': designation,
    'specialization': specialization,
  };
}

class RegisterRequest {
  const RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.universityName,
    required this.role,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    this.otherName,
    this.studentData,
    this.educatorData,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? otherName;
  final String universityName;
  final String role;
  final String phoneNumber;
  final String gender;
  final String dateOfBirth;
  final StudentData? studentData;
  final EducatorData? educatorData;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'other_name': otherName,
      'university_name': universityName,
      'role': role,
      'phone_number': phoneNumber,
      'gender': gender,
      'date_of_birth': dateOfBirth,
    };

    if (studentData != null) {
      json['student_data'] = studentData!.toJson();
    }
    if (educatorData != null) {
      json['educator_data'] = educatorData!.toJson();
    }

    return json;
  }
}
