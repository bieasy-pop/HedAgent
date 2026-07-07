import 'package:hedagent/features/authentication/data/models/auth_response.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  const AuthSuccess(this.response);

  final AuthResponse response;
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;
}
