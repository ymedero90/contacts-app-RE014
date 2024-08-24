part of 'contact_register_bloc.dart';

sealed class RegisterContactFormEvent extends Equatable {
  const RegisterContactFormEvent();

  @override
  List<Object> get props => [];
}

final class FormSubmitted extends RegisterContactFormEvent {
  final String? id;
  final String name;
  final String phoneNumber;
  final bool isEditing;
  final bool fromApp;

  const FormSubmitted({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.isEditing,
    required this.fromApp,
  });
}
