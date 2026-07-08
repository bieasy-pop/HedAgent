import 'package:dio/dio.dart';
import 'package:hedagent/constants/text_urls.dart';
import 'package:hedagent/features/authentication/data/models/auth_response.dart';
import 'package:hedagent/features/authentication/data/models/login_request.dart';
import 'package:hedagent/features/authentication/data/models/register_request.dart';
import 'package:hedagent/features/authentication/data/models/student_profile_request.dart';

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthRepository {
  AuthRepository({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Options _authHeader(String token) {
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  String? _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic> && data['message'] is String) {
      return data['message'] as String;
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'Could not reach the server. Check your connection and try again.';
      default:
        return null;
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    final Response<dynamic> response;
    try {
      response = await _dio.post(
        ApiConstants.registerEndpoint,
        data: request.toJson(),
        options: Options(contentType: Headers.jsonContentType),
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractMessage(e) ?? 'Registration failed. Please try again.',
      );
    }

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw AuthException('Received an unexpected response from server.');
    }
    return AuthResponse.fromJson(body);
  }

  Future<AuthResponse> login(LoginRequest request) async {
    final Response<dynamic> response;
    try {
      response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: request.toJson(),
        options: Options(contentType: Headers.jsonContentType),
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractMessage(e) ?? 'Login failed. Please try again.',
      );
    }

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw AuthException('Received an unexpected response from server.');
    }
    return AuthResponse.fromJson(body);
  }

  /// Asks the backend to (re)send the account's verification email.
  Future<void> sendVerificationEmail(String token) async {
    try {
      await _dio.post(
        ApiConstants.sendVerificationEndpoint,
        options: _authHeader(token),
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractMessage(e) ?? 'Could not send verification email.',
      );
    }
  }

  /// Checks whether the current account's email has been verified.
  Future<bool> isEmailVerified(String token) async {
    final Response<dynamic> response;
    try {
      response = await _dio.post(
        ApiConstants.verifyEmailEndpoint,
        options: _authHeader(token),
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractMessage(e) ?? 'Could not check verification status.',
      );
    }

    final body = response.data;
    if (body is Map<String, dynamic>) {
      if (body['verified'] is bool) {
        return body['verified'] as bool;
      }
      if (body['is_verified'] is bool) {
        return body['is_verified'] as bool;
      }
      final user = body['user'];
      if (user is Map<String, dynamic> && user['is_verified'] is bool) {
        return user['is_verified'] as bool;
      }
    }
    return false;
  }

  /// Fetches the canonical current-user record.
  Future<AuthUser> getCurrentUser(String token) async {
    final Response<dynamic> response;
    try {
      response = await _dio.get(
        ApiConstants.meEndpoint,
        options: _authHeader(token),
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractMessage(e) ?? 'Could not fetch account details.',
      );
    }

    final body = response.data;
    if (body is Map<String, dynamic>) {
      final userJson = body['user'] is Map<String, dynamic>
          ? body['user'] as Map<String, dynamic>
          : body;
      return AuthUser.fromJson(userJson);
    }
    throw AuthException('Received an unexpected response from server.');
  }

  /// Completes/updates a student's academic profile (grade level,
  /// department, GPA, attendance rate), addressed by student id. The
  /// backend responds with the freshly computed risk score/label and AI
  /// summary.
  Future<StudentProfile> completeStudentProfile(
    String token,
    String studentId,
    StudentProfileRequest request,
  ) async {
    final Response<dynamic> response;
    try {
      response = await _dio.patch(
        ApiConstants.myStudentProfileEndpoint,
        data: request.toJson(),
        options: _authHeader(
          token,
        ).copyWith(contentType: Headers.jsonContentType),
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractMessage(e) ?? 'Could not update your profile. Try again.',
      );
    }

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw AuthException('Received an unexpected response from server.');
    }
    return StudentProfile.fromJson(body);
  }

  /// Fetches a single student's academic profile by id (e.g. for an
  /// educator opening a student's detail page).
  Future<StudentProfile> getStudentById(String token, String studentId) async {
    final Response<dynamic> response;
    try {
      response = await _dio.get(
        ApiConstants.studentEndpoint(studentId),
        options: _authHeader(token),
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractMessage(e) ?? 'Could not fetch this student.',
      );
    }

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw AuthException('Received an unexpected response from server.');
    }
    return StudentProfile.fromJson(body);
  }

  /// Fetches the signed-in student's own canonical academic profile.
  Future<StudentProfile> getMyStudentProfile(String token) async {
    final Response<dynamic> response;
    try {
      response = await _dio.get(
        ApiConstants.myStudentProfileEndpoint,
        options: _authHeader(token),
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractMessage(e) ?? 'Could not fetch your profile.',
      );
    }

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw AuthException('Received an unexpected response from server.');
    }
    return StudentProfile.fromJson(body);
  }
}
