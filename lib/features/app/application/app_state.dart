part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    this.status = AppStatus.initial,
  });
  final AppStatus status;

  const AppState.initial() : this._();

  const AppState.sessionExpired() : this._(status: AppStatus.sessionExpired);
  const AppState.sessionFinished() : this._(status: AppStatus.sessionFinished);

  @override
  List<Object?> get props => [status];
}
