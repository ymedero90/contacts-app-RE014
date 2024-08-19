part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.checkingUserSession,
    this.user,
  });

  const AuthState.initial() : this._();

  const AuthState.submitting() : this._(status: AuthStatus.submitting);

  const AuthState.userSessionChecked() : this._(status: AuthStatus.checkedUserSession);

  const AuthState.sessionActive(UserEntity user) : this._(status: AuthStatus.autoLogin, user: user);

  const AuthState.authenticated(UserEntity user) : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final UserEntity? user;

  @override
  List<Object?> get props => [status, user];
}
