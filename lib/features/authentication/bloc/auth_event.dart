import 'package:hedagent/features/authentication/data/models/register_request.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class RegisterRequested extends AuthEvent {
  const RegisterRequested(this.request);

  final RegisterRequest request;
}
