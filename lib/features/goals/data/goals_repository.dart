import 'package:dio/dio.dart';
import 'package:hedagent/constants/text_urls.dart';
import 'package:hedagent/features/goals/models/goal.dart';

class GoalException implements Exception {
  GoalException(this.message);

  final String message;

  @override
  String toString() => message;
}

class GoalsRepository {
  GoalsRepository({Dio? dio}) : _dio = dio ?? Dio();

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

  /// Creates a new goal for the signed-in student.
  Future<Goal> createGoal(String token, String description) async {
    final Response<dynamic> response;
    try {
      response = await _dio.post(
        ApiConstants.goalsEndpoint,
        data: {'description': description},
        options: _authHeader(
          token,
        ).copyWith(contentType: Headers.jsonContentType),
      );
    } on DioException catch (e) {
      throw GoalException(_extractMessage(e) ?? 'Could not save your goal.');
    }

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw GoalException('Received an unexpected response from server.');
    }
    return Goal.fromJson(body);
  }

  /// Lists all goals belonging to the signed-in student.
  Future<List<Goal>> getGoals(String token) async {
    final Response<dynamic> response;
    try {
      response = await _dio.get(
        ApiConstants.goalsEndpoint,
        options: _authHeader(token),
      );
    } on DioException catch (e) {
      print('Error fetching goals: ${e.message}'); // Debugging line
      throw GoalException(_extractMessage(e) ?? 'Could not load your goals.');
    }

    final body = response.data;
    if (body is! List) {
      throw GoalException('Received an unexpected response from server.');
    }
    return body.whereType<Map<String, dynamic>>().map(Goal.fromJson).toList();
  }

  /// Fetches a single goal by id.
  Future<Goal> getGoalById(String token, String goalId) async {
    final Response<dynamic> response;
    try {
      response = await _dio.get(
        ApiConstants.goalByIdEndpoint(goalId),
        options: _authHeader(token),
      );
    } on DioException catch (e) {
      throw GoalException(_extractMessage(e) ?? 'Could not load this goal.');
    }

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw GoalException('Received an unexpected response from server.');
    }
    return Goal.fromJson(body);
  }
}
