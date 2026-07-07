/// Keys used to read/write values in `flutter_secure_storage`.
///
/// Centralized here so every read/write agrees on the exact key string,
/// and so it's documented in one place what each key holds.
class SecureStorageKeys {
  /// Bearer token returned by `/api/auth/register` or `/api/auth/login`.
  /// Sent as `Authorization: Bearer <token>` on authenticated requests.
  static const String authToken = 'auth_token';

  /// JSON-encoded [AuthUser] snapshot (see `data/models/auth_response.dart`),
  /// refreshed after login and after a successful email verification check.
  static const String userData = 'user_data';

  /// `'true'` / `'false'` mirror of `user.isVerified`, cached alongside
  /// [userData] for quick reads without decoding the full JSON blob.
  static const String isVerified = 'is_verified';

  /// The account role (`'student'` or `'educator'`), cached alongside
  /// [userData] for quick reads without decoding the full JSON blob.
  static const String userRole = 'user_role';
}
