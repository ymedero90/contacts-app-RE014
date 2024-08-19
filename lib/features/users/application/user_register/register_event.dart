part of 'register_bloc.dart';

sealed class RegisterUserFormEvent extends Equatable {
  const RegisterUserFormEvent();

  @override
  List<Object> get props => [];
}

final class FormSubmitted extends RegisterUserFormEvent {
  final String name;
  final String email;
  final String password;

  const FormSubmitted({required this.name, required this.email, required this.password});
}
