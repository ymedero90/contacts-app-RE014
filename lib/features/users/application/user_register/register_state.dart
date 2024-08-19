part of 'register_bloc.dart';

final class RegisterUserFormState extends Equatable {
  const RegisterUserFormState({this.status = RegisterUserStatus.initial});

  final RegisterUserStatus status;

  RegisterUserFormState copyWith({RegisterUserStatus? status}) {
    return RegisterUserFormState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
