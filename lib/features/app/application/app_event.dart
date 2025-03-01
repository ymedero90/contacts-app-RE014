part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppLogin extends AppEvent {
  final String email;
  final String password;

  AppLogin({required this.email, required this.password});
}

final class AppLogout extends AppEvent {
  final String email;

  AppLogout({required this.email});
}

final class AppInitialEvent extends AppEvent {
  AppInitialEvent();
}

final class AppSessionExpired extends AppEvent {
  AppSessionExpired();
}

final class AppSessionRenew extends AppEvent {
  final bool renew;

  AppSessionRenew({required this.renew});
}
