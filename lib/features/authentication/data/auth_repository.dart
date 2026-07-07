import 'dart:convert';

import 'package:hedagent/constants/text_urls.dart';
import 'package:hedagent/features/authentication/data/models/auth_response.dart';
import 'package:hedagent/features/authentication/data/models/register_request.dart';
import 'package:http/http.dart' as http;

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthRepository {
  AuthRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<AuthResponse> register(RegisterRequest request) async {
    late final http.Response response;
    try {
      response = await _client.post(
        Uri.parse(ApiConstants.registerEndpoint),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
    } catch (_) {
      throw AuthException(
        'Could not reach the server. Check your connection and try again.',
      );
    }

    Map<String, dynamic>? body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      body = null;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (body == null) {
        throw AuthException('Received an unexpected response from server.');
      }
      return AuthResponse.fromJson(body);
    }

    final message = body?['message'] as String?;
    throw AuthException(message ?? 'Registration failed. Please try again.');
  }
}
