part of 'contact_register_bloc.dart';

sealed class RegisterContactFormEvent extends Equatable {
  const RegisterContactFormEvent();

  @override
  List<Object> get props => [];
}

final class NameChanged extends RegisterContactFormEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

final class IdChanged extends RegisterContactFormEvent {
  const IdChanged({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

final class FormSubmitted extends RegisterContactFormEvent {}
