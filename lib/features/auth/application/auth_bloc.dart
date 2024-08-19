import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/features/auth/domain/core/auth_status.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/users/domain/entities/user_entity.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
    on<AuthInitialEvent>(_onInitialRequested);

    add(AuthInitialEvent());
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  Future<void> _onSubscriptionRequested(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.submitting());
    final respGetUser = await _userRepository.getUser(email: event.email);
    await Future.delayed(Durations.extralong4);
    respGetUser.fold((l) {
      emit(const AuthState.unauthenticated());
    }, (user) async {
      if (user.password != event.password) {
        emit(const AuthState.unauthenticated());
      }
      final resp = await _authRepository.login(email: event.email, password: event.password);
      resp.fold((l) {
        emit(const AuthState.unauthenticated());
      }, (r) {
        emit(AuthState.authenticated(user));
      });
    });
  }

  Future<void> _onInitialRequested(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) async {
    final userLoggedResp = await _authRepository.getSession();
    await Future.delayed(Durations.extralong4);
    userLoggedResp.fold((l) {
      emit(const AuthState.userSessionChecked());
    }, (email) async {
      final userResp = await _userRepository.getUser(email: email);
      userResp.fold((l) {
        emit(const AuthState.userSessionChecked());
      }, (user) async {
        emit(AuthState.sessionActive(user));
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
