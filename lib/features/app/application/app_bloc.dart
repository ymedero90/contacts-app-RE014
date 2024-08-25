import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/features/app/domain/core/app_status.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AppState.initial()) {
    on<AppInitialEvent>(_onInitialRequested);
    on<AppSessionExpired>(_onSessionExpired);
    on<AppSessionRenew>(_onSessionRenew);
    add(AppInitialEvent());
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  late Timer timer;
  int timerGeneralMin = 2;
  late Timer timerSecondary;
  int timerSecondarySeconds = 10;

  Future<void> _onInitialRequested(
    AppInitialEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(const AppState.initial());
    timer = Timer.periodic(Duration(minutes: timerGeneralMin), (timer) {
      add(AppSessionExpired());
      timer.cancel();
    });
  }

  Future<void> _onSessionExpired(
    AppSessionExpired event,
    Emitter<AppState> emit,
  ) async {
    emit(const AppState.sessionExpired());
    timerSecondary = Timer.periodic(Duration(seconds: timerSecondarySeconds), (timer) async {
      add(AppSessionRenew(renew: false));
      timer.cancel();
    });
  }

  Future<void> _onSessionRenew(
    AppSessionRenew event,
    Emitter<AppState> emit,
  ) async {
    if (event.renew) {
      emit(const AppState.initial());
      timerSecondary.cancel();
      timer = Timer.periodic(Duration(minutes: timerGeneralMin), (timer) {
        add(AppSessionExpired());
        timer.cancel();
      });
    } else {
      await _authRepository.logout();
      emit(const AppState.sessionFinished());
    }
  }
}
