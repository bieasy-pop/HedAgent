class LoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
    this.onesignalPlayerId,
  });

  final String email;
  final String password;
  final String? onesignalPlayerId;

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'onesignal_player_id': onesignalPlayerId,
  };
}
