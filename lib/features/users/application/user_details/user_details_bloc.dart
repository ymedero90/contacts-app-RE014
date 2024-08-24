import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/users/domain/index.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
    required ImagePickerService imagePickerService,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _imagePickerService = imagePickerService,
        super(const UserDetailsState.initail()) {
    on<OnGetUserEvent>(_onGetUser);
    on<OnChangeUserAvatarEvent>(_onChangeUserAvatarEvent);
    on<OnLogoutEvent>(_onLogoutEvent);
    add(OnGetUserEvent());
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final ImagePickerService _imagePickerService;

  Future<void> _onGetUser(
    OnGetUserEvent event,
    Emitter<UserDetailsState> emit,
  ) async {
    final respSession = await _authRepository.getSession();
    await respSession.fold((l) {
      emit(UserDetailsState.fail(l.message.body));
    }, (email) async {
      final respUser = await _userRepository.getUser(email: email);
      respUser.fold((l) {}, (user) {
        emit(UserDetailsState.fetched(user));
      });
    });
  }

  Future<void> _onChangeUserAvatarEvent(
    OnChangeUserAvatarEvent event,
    Emitter<UserDetailsState> emit,
  ) async {
    File? image;
    if (event.source == ImageSource.camera) {
      image = await _imagePickerService.captureImageWithCamera();
    } else {
      image = await _imagePickerService.pickImageFromGallery();
    }
    final resp = await _userRepository.addUser(user: state.user!.copyWith(avatar: image?.path));
    resp.fold((l) {
      emit(UserDetailsState.fail(l.message.body));
    }, (r) {
      emit(UserDetailsState.avatarChanged(state.user!.copyWith(avatar: image!.path)));
    });
  }

  Future<void> _onLogoutEvent(
    OnLogoutEvent event,
    Emitter<UserDetailsState> emit,
  ) async {
    final resp = await _authRepository.logout();
    resp.fold((l) {
      emit(UserDetailsState.fail(l.message.body));
    }, (r) {
      emit(const UserDetailsState.logout());
    });
  }
}
