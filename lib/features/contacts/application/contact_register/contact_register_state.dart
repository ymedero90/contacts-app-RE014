part of 'contact_register_bloc.dart';

final class RegisterContactFormState extends Equatable {
  const RegisterContactFormState({
    this.id = '',
    this.name = '',
    this.isValid = false,
    this.status = RegisterContactStatus.initial,
  });

  final String id;
  final String name;
  final bool isValid;
  final RegisterContactStatus status;

  RegisterContactFormState copyWith({
    String? id,
    String? name,
    bool? isValid,
    RegisterContactStatus? status,
  }) {
    return RegisterContactFormState(
      id: id ?? this.id,
      name: name ?? this.name,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [id, name, isValid, status];
}
