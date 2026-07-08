class ApiConstants {
  static const String baseUrl = 'https://hedagent-backend.onrender.com';
  static const String registerEndpoint = '$baseUrl/api/auth/register';
  static const String loginEndpoint = '$baseUrl/api/auth/login';
  static const String sendVerificationEndpoint =
      '$baseUrl/api/auth/send-verification';
  static const String verifyEmailEndpoint = '$baseUrl/api/auth/verify-email';
  static const String meEndpoint = '$baseUrl/api/auth/me';

  /// GET (fetch) and PATCH (complete/update) endpoint for a single
  /// student's academic profile (grade level, department, GPA,
  /// attendance rate, etc.), addressed by student id.
  static String studentEndpoint(String studentId) =>
      '$baseUrl/api/students/$studentId';

  /// GET endpoint used by a signed-in student to fetch their own
  /// canonical academic profile.
  static const String myStudentProfileEndpoint = '$baseUrl/api/students/me';

  /// POST (create) and GET (list) endpoint for the signed-in student's
  /// goals.
  static const String goalsEndpoint = '$baseUrl/api/goals/';

  /// GET endpoint for a single goal by id.
  static String goalByIdEndpoint(String goalId) =>
      '$baseUrl/api/goals/$goalId';
}
