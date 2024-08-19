part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  const AuthState.initial() : this._();

  const AuthState.authenticated(UserEntity user) : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);
  const AuthState.wrongPassword() : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final UserEntity? user;

  @override
  List<Object?> get props => [status, user];
}
