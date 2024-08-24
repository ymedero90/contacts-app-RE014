import 'dart:async';

import 'package:bloc/bloc.dart';
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

    add(AppInitialEvent());
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  Future<void> _onInitialRequested(
    AppInitialEvent event,
    Emitter<AppState> emit,
  ) async {}
}
