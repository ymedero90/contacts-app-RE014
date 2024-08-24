import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service%20copy/index.dart';
import 'package:contacts_app_re014/features/auth/domain/core/auth_status.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/users/domain/entities/user_entity.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
    required SecurityService securityService,
    required BiometricAuthService biometricAuthService,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _securityService = securityService,
        _biometricAuthService = biometricAuthService,
        super(const AuthState.initial()) {
    on<AuthLogin>(_onSubscriptionRequested);
    on<AuthLogout>(_onLogoutPressed);
    on<AuthInitialEvent>(_onInitialRequested);
    on<SetBiometric>(_onSetBiometric);
    on<AskForBiometric>(_onAskForBiometric);

    add(AuthInitialEvent(loginOnlyWithCred: false));
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final SecurityService _securityService;
  final BiometricAuthService _biometricAuthService;

  Future<void> _onSubscriptionRequested(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.submitting());
    final respCred = await _authRepository.getCredentials(email: event.email);
    await respCred.fold((l) {
      emit(const AuthState.unauthenticated());
    }, (cred) async {
      //   await _authRepository.registerCredentials(data: cred.copyWith(firstLoggin: true));
      final samePassword = _securityService.verifyPassword(event.password, cred.password);
      if (!samePassword) {
        emit(const AuthState.unauthenticated());
      } else {
        final resp = await _authRepository.login(email: event.email);
        await resp.fold((l) {
          emit(const AuthState.unauthenticated());
        }, (r) async {
          final userResp = await _userRepository.getUser(email: event.email);
          await userResp.fold((l) {
            emit(const AuthState.unauthenticated());
          }, (user) async {
            if (cred.firstLoggin) {
              await _authRepository.registerCredentials(data: cred.copyWith(firstLoggin: false));
              await checkBiometricAvailability(emit, user);
            } else {
              emit(AuthState.authenticated(user));
            }
          });
        });
      }
    });
  }

  Future<void> _onInitialRequested(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.initial());
    if (event.loginOnlyWithCred) {
      emit(const AuthState.sessionInactive());
    } else {
      final userLoggedResp = await _authRepository.getSession();
      await userLoggedResp.fold((l) {
        emit(const AuthState.sessionInactive());
      }, (emailActive) async {
        final userResp = await _userRepository.getUser(email: emailActive);
        await userResp.fold((l) {
          emit(const AuthState.sessionInactive());
        }, (user) async {
          final userLoggedResp = await _authRepository.getCredentials(email: emailActive);
          await userLoggedResp.fold((l) {
            emit(const AuthState.sessionInactive());
          }, (authData) async {
            if (!event.loginOnlyWithCred && authData.allowBiometric) {
              add(AskForBiometric(user: user));
            } else {
              emit(AuthState.sessionActive(user));
            }
          });
        });
      });
    }
  }

  Future<void> checkBiometricAvailability(Emitter<AuthState> emit, UserEntity user) async {
    final isBiometricAvailable = await _biometricAuthService.isBiometricAvailable();
    if (isBiometricAvailable) {
      emit(AuthState.biometricStatus(user, AuthStatus.biometricSupported));
    } else {
      emit(AuthState.biometricStatus(user, AuthStatus.biometricNotSupport));
    }
  }

  Future<void> _onSetBiometric(
    SetBiometric event,
    Emitter<AuthState> emit,
  ) async {
    final userLoggedResp = await _authRepository.getCredentials(email: event.email);
    await userLoggedResp.fold((l) {}, (authData) async {
      final newAuthData = authData.copyWith(allowBiometric: event.allow);
      await _authRepository.registerCredentials(data: newAuthData);
      emit(AuthState.biometricStatus(
        state.user!,
        event.allow ? AuthStatus.biometricAllowed : AuthStatus.biometricNotAllowed,
      ));
    });
  }

  Future<void> _onAskForBiometric(
    AskForBiometric event,
    Emitter<AuthState> emit,
  ) async {
    final isAuthenticated = await _biometricAuthService.authenticate(
      reason: 'Please authenticate to access your account',
      useBiometricsOnly: true,
    );

    if (isAuthenticated) {
      emit(AuthState.biometricStatus(event.user, AuthStatus.biometricSuccess));
      emit(AuthState.sessionActive(event.user));
    } else {
      emit(AuthState.biometricStatus(event.user, AuthStatus.biometricFail));
    }
  }

  Future<void> _onLogoutPressed(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout(email: event.email);
  }
}
