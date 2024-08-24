// import 'package:contacts_app_re014/common/index.dart';
// import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/constants.dart';
// import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/local_storage_service.dart';
// import 'package:contacts_app_re014/features/auth/domain/datasources/auth_local_datasource.dart';
// import 'package:contacts_app_re014/features/auth/infrastructure/dtos/auth_data_dto.dart';

// class AuthLocalDataSource implements IAuthLocalDataSource {
//   final LocalStorageService localStorageService;

//   AuthLocalDataSource({required this.localStorageService});

//   @override
//   Future<void> login({required String email}) async {
//     await localStorageService.put(BoxKeys.SessionKey, email, LocalBoxes.AppBox);
//   }

//   @override
//   Future<void> logout() async {
//     await localStorageService.delete(BoxKeys.SessionKey, LocalBoxes.AppBox);
//   }

//   @override
//   Future<String> getSession() async {
//     final response = await localStorageService.get(BoxKeys.SessionKey, LocalBoxes.AppBox);
//     if (response != null) {
//       return response;
//     }
//     throw Exception(const ResourceNotFound());
//   }

//   @override
//   Future<AuthDataDto> getCredentials({required String email}) {
//     // TODO: implement getCredentials
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> registerCredentials({required String email, required AuthDataDto data}) {
//     // TODO: implement registerCredentials
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setSession({required String email}) {
//     // TODO: implement setSession
//     throw UnimplementedError();
//   }
// }
