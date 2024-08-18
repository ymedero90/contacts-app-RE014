part of 'user_details_bloc.dart';

enum ImageSource { gallery, camera }

sealed class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

final class OnGetUserEvent extends UserDetailsEvent {}

final class OnChangeUserAvatarEvent extends UserDetailsEvent {
  final ImageSource source;

  const OnChangeUserAvatarEvent({required this.source});
}
