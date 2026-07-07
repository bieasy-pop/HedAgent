import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hedagent/constants/secure_storage_keys.dart';
import 'package:hedagent/features/authentication/data/models/auth_response.dart';

/// Wraps [FlutterSecureStorage] with typed read/write helpers for the
/// session data cached on device. See [SecureStorageKeys] for what each
/// underlying key holds.
class UserStorageService {
  UserStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) {
    return _storage.write(key: SecureStorageKeys.authToken, value: token);
  }

  Future<String?> getToken() {
    return _storage.read(key: SecureStorageKeys.authToken);
  }

  Future<void> saveUser(AuthUser user) async {
    await _storage.write(
      key: SecureStorageKeys.userData,
      value: jsonEncode(user.toJson()),
    );
    await _storage.write(
      key: SecureStorageKeys.isVerified,
      value: user.isVerified.toString(),
    );
    await _storage.write(key: SecureStorageKeys.userRole, value: user.role);
  }

  Future<AuthUser?> getUser() async {
    final raw = await _storage.read(key: SecureStorageKeys.userData);
    if (raw == null) {
      return null;
    }
    return AuthUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> clear() => _storage.deleteAll();
}
