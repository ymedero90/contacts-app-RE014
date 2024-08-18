part of 'user_details_bloc.dart';

class UserDetailsState extends Equatable {
  const UserDetailsState._({this.user, this.error});

  const UserDetailsState.initail() : this._();

  const UserDetailsState.fetched(UserEntity user) : this._(user: user);

  const UserDetailsState.avatarChanged(UserEntity user) : this._(user: user);

  const UserDetailsState.fail(String? error) : this._(error: error);

  final UserEntity? user;
  final String? error;

  @override
  List<Object?> get props => [user, error];
}
