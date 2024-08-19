import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/features/users/domain/core/user_register_status.dart';
import 'package:contacts_app_re014/features/users/domain/index.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterUserFormBloc extends Bloc<RegisterUserFormEvent, RegisterUserFormState> {
  RegisterUserFormBloc({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const RegisterUserFormState()) {
    on<FormSubmitted>(_onFormSubmitted);
  }

  final IUserRepository _userRepository;

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
            password: event.password,
          ),
        );
        resp.fold((l) {
          emit(state.copyWith(status: RegisterUserStatus.fail));
        }, (r) async {
          emit(state.copyWith(status: RegisterUserStatus.success));
        });
      },
      (user) async {
        emit(state.copyWith(status: RegisterUserStatus.emailAlreadyExist));
      },
    );
  }
}
