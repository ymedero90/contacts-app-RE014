part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthLogout extends AuthEvent {
  final String email;

  AuthLogout({required this.email});
}

final class SetBiometric extends AuthEvent {
  final String email;
  final bool allow;

  SetBiometric({required this.email, required this.allow});
}

final class AskForBiometric extends AuthEvent {
  final UserEntity user;

  AskForBiometric({required this.user});
}

final class AuthInitialEvent extends AuthEvent {
  final bool loginOnlyWithCred;
  AuthInitialEvent({required this.loginOnlyWithCred});
}
