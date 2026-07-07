class ApiConstants {
  static const String baseUrl = 'https://hedagent-backend.onrender.com';
  static const String registerEndpoint = '$baseUrl/api/auth/register';
  static const String loginEndpoint = '$baseUrl/api/auth/login';
  static const String sendVerificationEndpoint =
      '$baseUrl/api/auth/send-verification';
  static const String verifyEmailEndpoint = '$baseUrl/api/auth/verify-email';
  static const String meEndpoint = '$baseUrl/api/auth/me';
}
