import 'dart:async';

import 'package:bloc/bloc.dart';
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
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.initial()) {
    on<AuthLogin>(_onSubscriptionRequested);
    on<AuthLogout>(_onLogoutPressed);
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  Future<void> _onSubscriptionRequested(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final respGetUser = await _userRepository.getUser(email: event.email);
    respGetUser.fold((l) {
      emit(const AuthState.unauthenticated());
    }, (user) async {
      if (user.password != event.password) {
        emit(const AuthState.wrongPassword());
      }
      final resp = await _authRepository.login(email: event.email, password: event.password);
      resp.fold((l) {
        emit(const AuthState.unauthenticated());
      }, (r) {
        emit(AuthState.authenticated(user));
      });
    });
  }

  Future<void> _onLogoutPressed(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout(email: event.email);
  }
}
