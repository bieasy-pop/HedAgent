import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hedagent/features/authentication/bloc/auth_event.dart';
import 'package:hedagent/features/authentication/bloc/auth_state.dart';
import 'package:hedagent/features/authentication/data/auth_repository.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AuthRepository? authRepository, UserStorageService? storageService})
    : _authRepository = authRepository ?? AuthRepository(),
      _storageService = storageService ?? UserStorageService(),
      super(const AuthInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
    on<LoginRequested>(_onLoginRequested);
    on<CheckEmailVerification>(_onCheckEmailVerification);
    on<ResendVerificationEmail>(_onResendVerificationEmail);
  }

  final AuthRepository _authRepository;
  final UserStorageService _storageService;

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final response = await _authRepository.register(event.request);
      await _storageService.saveToken(response.token);
      await _storageService.saveUser(response.user);
      try {
        await _authRepository.sendVerificationEmail(response.token);
      } catch (_) {
        // Best-effort: the user can retry from the verification screen.
      }
      emit(RegisterSuccess(response));
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (_) {
      emit(const AuthFailure('Something went wrong. Please try again.'));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final loginResponse = await _authRepository.login(event.request);
      await _storageService.saveToken(loginResponse.token);
      final user = await _authRepository.getCurrentUser(loginResponse.token);
      await _storageService.saveUser(user);
      emit(LoginSuccess(user));
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (_) {
      emit(const AuthFailure('Something went wrong. Please try again.'));
    }
  }

  Future<void> _onCheckEmailVerification(
    CheckEmailVerification event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final token = await _storageService.getToken();
      if (token == null) {
        emit(const AuthFailure('Session expired. Please log in again.'));
        return;
      }

      final verified = await _authRepository.isEmailVerified(token);
      if (!verified) {
        emit(const VerificationPending());
        return;
      }

      final user = await _authRepository.getCurrentUser(token);
      await _storageService.saveUser(user);
      emit(VerificationConfirmed(user));
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (_) {
      emit(const AuthFailure('Something went wrong. Please try again.'));
    }
  }

  Future<void> _onResendVerificationEmail(
    ResendVerificationEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final token = await _storageService.getToken();
      if (token == null) {
        emit(const AuthFailure('Session expired. Please log in again.'));
        return;
      }

      await _authRepository.sendVerificationEmail(token);
      emit(const VerificationEmailResent());
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (_) {
      emit(const AuthFailure('Something went wrong. Please try again.'));
    }
  }
}
