part of 'contact_register_bloc.dart';

final class RegisterContactFormState extends Equatable {
  const RegisterContactFormState({
    this.status = RegisterContactStatus.initial,
  });

  final RegisterContactStatus status;

  RegisterContactFormState copyWith({
    RegisterContactStatus? status,
  }) {
    return RegisterContactFormState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
