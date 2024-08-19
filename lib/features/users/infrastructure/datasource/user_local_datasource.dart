import 'dart:convert';

import 'package:contacts_app_re014/common/domain/error_handler/message/messages.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/constants.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/local_storage_service.dart';
import 'package:contacts_app_re014/features/users/domain/datasources/user_local_datasource.dart';
import 'package:contacts_app_re014/features/users/infrastructure/dtos/user_dto.dart';

class UserLocalDataSource implements IUserLocalDataSource {
  final LocalStorageService localStorageService;

  UserLocalDataSource({required this.localStorageService});

  @override
  Future<void> addUser({required UserDto user}) async {
    final data = json.encode(user.toJson());
    await localStorageService.put(
      user.email,
      data,
      LocalBoxes.UsersBox,
    );
  }

  @override
  Future<UserDto> getUser({required String email}) async {
    final data = await localStorageService.get(email, LocalBoxes.UsersBox);
    if (data != null) {
      final decoded = json.decode(data);
      final response = UserDto.fromJson(decoded);
      return response;
    }
    throw Exception(const ResourceNotFound());
  }

  @override
  Future<List<UserDto>> getUsers() async {
    final data = await localStorageService.getAll(LocalBoxes.UsersBox);
    final decoded = data.map((e) => json.decode(e)).toList();
    final response = decoded.map((e) => UserDto.fromJson(e)).toList();
    return response;
  }

  @override
  Future<void> deleteUser({required String email}) async {
    await localStorageService.delete(
      email,
      LocalBoxes.UsersBox,
    );
  }
}
