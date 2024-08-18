part of 'register_bloc.dart';

sealed class RegisterUserFormEvent extends Equatable {
  const RegisterUserFormEvent();

  @override
  List<Object> get props => [];
}

final class EmailChanged extends RegisterUserFormEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

final class NameChanged extends RegisterUserFormEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

final class NameUnfocused extends RegisterUserFormEvent {}

final class EmailUnfocused extends RegisterUserFormEvent {}

final class PasswordChanged extends RegisterUserFormEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

final class PasswordUnfocused extends RegisterUserFormEvent {}

final class ConfirmPasswordUnfocused extends RegisterUserFormEvent {
  const ConfirmPasswordUnfocused({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

final class FormSubmitted extends RegisterUserFormEvent {}
