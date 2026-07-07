import 'package:hedagent/features/authentication/data/models/login_request.dart';
import 'package:hedagent/features/authentication/data/models/register_request.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class RegisterRequested extends AuthEvent {
  const RegisterRequested(this.request);

  final RegisterRequest request;
}

class LoginRequested extends AuthEvent {
  const LoginRequested(this.request);

  final LoginRequest request;
}

class CheckEmailVerification extends AuthEvent {
  const CheckEmailVerification();
}

class ResendVerificationEmail extends AuthEvent {
  const ResendVerificationEmail();
}
