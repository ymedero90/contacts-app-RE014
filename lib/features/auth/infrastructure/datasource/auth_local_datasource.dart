import 'dart:convert';

import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/constants.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/local_storage_service.dart';
import 'package:contacts_app_re014/features/auth/domain/datasources/auth_local_datasource.dart';
import 'package:contacts_app_re014/features/auth/infrastructure/dtos/auth_data_dto.dart';

class AuthLocalDataSource implements IAuthLocalDataSource {
  final LocalStorageService localStorageService;

  AuthLocalDataSource({required this.localStorageService});

  @override
  Future<void> setSession({required String email}) async {
    await localStorageService.put(BoxKeys.SessionKey, email, LocalBoxes.AuthBox);
  }

  @override
  Future<String> getSession() async {
    final response = await localStorageService.get(BoxKeys.SessionKey, LocalBoxes.AuthBox);
    if (response != null) {
      return response;
    }
    throw Exception(const ResourceNotFound());
  }

  @override
  Future<void> logout() async {
    await localStorageService.delete(BoxKeys.SessionKey, LocalBoxes.AuthBox);
  }

  @override
  Future<void> registerCredentials({required AuthDataDto data}) async {
    final encodeData = json.encode(data.toJson());
    await localStorageService.put(data.email, encodeData, LocalBoxes.AuthBox);
  }

  @override
  Future<AuthDataDto> getCredentials({required String email}) async {
    final response = await localStorageService.get(email, LocalBoxes.AuthBox);
    if (response != null) {
      final decodedData = json.decode(response);
      return AuthDataDto.fromJson(decodedData);
    }
    throw Exception(const ResourceNotFound());
  }
}
