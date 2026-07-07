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

/// Emitted after a successful `/api/auth/register` call.
class RegisterSuccess extends AuthState {
  const RegisterSuccess(this.response);

  final AuthResponse response;
}

/// Emitted after a successful login, once the canonical user record has
/// been fetched from `/api/auth/me` and cached.
class LoginSuccess extends AuthState {
  const LoginSuccess(this.user);

  final AuthUser user;
}

/// Emitted when a verification check comes back false.
class VerificationPending extends AuthState {
  const VerificationPending();
}

/// Emitted when a verification check confirms the email is verified.
class VerificationConfirmed extends AuthState {
  const VerificationConfirmed(this.user);

  final AuthUser user;
}

/// Emitted after successfully asking the backend to resend the
/// verification email.
class VerificationEmailResent extends AuthState {
  const VerificationEmailResent();
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;
}
