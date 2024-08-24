part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.checkingUserSession,
    this.user,
  });

  const AuthState.initial() : this._();

  const AuthState.submitting() : this._(status: AuthStatus.submitting);

  const AuthState.sessionActive(UserEntity user) : this._(status: AuthStatus.sessionActive, user: user);

  const AuthState.sessionInactive() : this._(status: AuthStatus.sessionInactive);

  const AuthState.authenticated(UserEntity user) : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  const AuthState.allowBiometrics(UserEntity user) : this._(status: AuthStatus.allowBiometrics, user: user);

  const AuthState.checkBiometrics(UserEntity user) : this._(status: AuthStatus.checkBiometrics, user: user);

  const AuthState.biometricStatus(UserEntity user, AuthStatus status) : this._(status: status, user: user);

  final AuthStatus status;
  final UserEntity? user;

  @override
  List<Object?> get props => [status, user];
}
