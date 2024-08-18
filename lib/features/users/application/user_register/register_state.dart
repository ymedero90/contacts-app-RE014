part of 'register_bloc.dart';

final class RegisterUserFormState extends Equatable {
  const RegisterUserFormState({
    this.email = '',
    this.isValid = false,
    this.name = '',
    this.password = '',
    this.status = RegisterUserStatus.initial,
  });

  final bool isValid;
  final RegisterUserStatus status;
  final String email;
  final String name;
  final String password;

  RegisterUserFormState copyWith({
    String? email,
    String? name,
    String? password,
    bool? isValid,
    RegisterUserStatus? status,
  }) {
    return RegisterUserFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, email, password, status];
}
