import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hedagent/features/authentication/bloc/auth_event.dart';
import 'package:hedagent/features/authentication/bloc/auth_state.dart';
import 'package:hedagent/features/authentication/data/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AuthRepository? authRepository, FlutterSecureStorage? secureStorage})
    : _authRepository = authRepository ?? AuthRepository(),
      _secureStorage = secureStorage ?? const FlutterSecureStorage(),
      super(const AuthInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  static const String authTokenKey = 'auth_token';

  final AuthRepository _authRepository;
  final FlutterSecureStorage _secureStorage;

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final response = await _authRepository.register(event.request);
      await _secureStorage.write(key: authTokenKey, value: response.token);
      emit(AuthSuccess(response));
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (_) {
      emit(const AuthFailure('Something went wrong. Please try again.'));
    }
  }
}
