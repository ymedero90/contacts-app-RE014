part of 'contact_register_bloc.dart';

sealed class RegisterContactFormEvent extends Equatable {
  const RegisterContactFormEvent();

  @override
  List<Object> get props => [];
}

final class FormSubmitted extends RegisterContactFormEvent {
  final String name;
  final String id;

  const FormSubmitted({required this.name, required this.id});
}
