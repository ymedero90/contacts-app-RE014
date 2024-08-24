import 'package:contacts_app_re014/features/auth/infrastructure/dtos/auth_data_dto.dart';

abstract class IAuthLocalDataSource {
  Future<void> setSession({required String email});
  Future<void> registerCredentials({required AuthDataDto data});
  Future<AuthDataDto> getCredentials({required String email});
  Future<String> getSession();
  Future<void> logout();
}
