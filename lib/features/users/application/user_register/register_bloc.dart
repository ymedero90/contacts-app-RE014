import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service%20copy/local_storage_service.dart';
import 'package:contacts_app_re014/features/auth/domain/entities/auth_data_entity.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/users/domain/index.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterUserFormBloc extends Bloc<RegisterUserFormEvent, RegisterUserFormState> {
  RegisterUserFormBloc({
    required IUserRepository userRepository,
    required IAuthRepository authRepository,
    required SecurityService securityService,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        _securityService = securityService,
        super(const RegisterUserFormState()) {
    on<FormSubmitted>(_onFormSubmitted);
  }

  final IUserRepository _userRepository;
  final IAuthRepository _authRepository;
  final SecurityService _securityService;

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<RegisterUserFormState> emit,
  ) async {
    emit(state.copyWith(status: RegisterUserStatus.submitting));
    final respUser = await _userRepository.getUser(email: event.email);
    await Future.delayed(Durations.extralong4);
    await respUser.fold(
      (l) async {
        final resp = await _userRepository.addUser(
          user: UserEntity(
            name: event.name,
            email: event.email,
          ),
        );
        resp.fold((l) {
          emit(state.copyWith(status: RegisterUserStatus.fail));
        }, (r) async {
          final hashPassword = _securityService.hashPassword(event.password);
          await _authRepository.registerCredentials(
            data: AuthDataEntity(
              email: event.email,
              password: hashPassword,
            ),
          );
          emit(state.copyWith(status: RegisterUserStatus.success));
        });
      },
      (user) async {
        emit(state.copyWith(status: RegisterUserStatus.emailAlreadyExist));
      },
    );
  }
}
