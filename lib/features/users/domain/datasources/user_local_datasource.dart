import 'package:contacts_app_re014/features/users/infrastructure/dtos/index.dart';

abstract class IUserLocalDataSource {
  Future<UserDto> getUser({required String email});
  Future<List<UserDto>> getUsers();
  Future<void> addUser({required UserDto user});
}
