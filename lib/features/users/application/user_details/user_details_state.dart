part of 'user_details_bloc.dart';

class UserDetailsState extends Equatable {
  const UserDetailsState._({this.user, this.status = UserDetailsStatus.loadingUser});

  const UserDetailsState.initail() : this._();

  const UserDetailsState.fetched(UserEntity user) : this._(user: user, status: UserDetailsStatus.loadedUser);

  const UserDetailsState.avatarChanged(UserEntity user) : this._(user: user, status: UserDetailsStatus.changedAvatar);

  const UserDetailsState.fail(String? error) : this._(status: UserDetailsStatus.fail);
  const UserDetailsState.logout() : this._(status: UserDetailsStatus.logout);

  final UserEntity? user;
  final UserDetailsStatus status;

  @override
  List<Object?> get props => [user, status];
}
