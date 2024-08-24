import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/common/infrastructura/services/security_service/index.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/local_storage_service.dart';
import 'package:contacts_app_re014/features/app/application/app_bloc.dart';
import 'package:contacts_app_re014/features/auth/application/auth_bloc.dart';
import 'package:contacts_app_re014/features/auth/domain/datasources/index.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/auth/infrastructure/datasource/auth_local_datasource.dart';
import 'package:contacts_app_re014/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/contacts/application/contact_register/contact_register_bloc.dart';
import 'package:contacts_app_re014/features/contacts/application/contacts_list/contacts_list_bloc.dart';
import 'package:contacts_app_re014/features/contacts/domain/datasources/contacts_local_datasource.dart';
import 'package:contacts_app_re014/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:contacts_app_re014/features/contacts/infrastructure/datasource/contacts_local_datasource.dart';
import 'package:contacts_app_re014/features/contacts/infrastructure/repositories/contacts_repository.dart';
import 'package:contacts_app_re014/features/users/application/user_details/user_details_bloc.dart';
import 'package:contacts_app_re014/features/users/application/user_register/register_bloc.dart';
import 'package:contacts_app_re014/features/users/domain/datasources/user_local_datasource.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:contacts_app_re014/features/users/infrastructure/datasource/user_local_datasource.dart';
import 'package:contacts_app_re014/features/users/infrastructure/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._init();

  static Injector? instance;
  static GetIt sl = GetIt.instance;

  T getDependency<T extends Object>() => sl.get();

  static Future<void> onInit() async {
    instance ??= Injector._init();
    await instance!._registerCore();
    instance!._registerDataSourceLayer();
    instance!._registerRepositoryLayer();
    instance!._registerCubits();
  }

  void _registerDataSourceLayer() {
    sl.registerLazySingleton<IAuthLocalDataSource>(
      () => AuthLocalDataSource(localStorageService: sl<LocalStorageService>()),
    );
    sl.registerLazySingleton<IUserLocalDataSource>(
      () => UserLocalDataSource(localStorageService: sl<LocalStorageService>()),
    );
    sl.registerLazySingleton<IContactsLocalDataSource>(
      () => ContactsLocalDataSource(localStorageService: sl<LocalStorageService>()),
    );
  }

  void _registerRepositoryLayer() {
    sl.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(local: sl<IAuthLocalDataSource>()),
    );
    sl.registerLazySingleton<IUserRepository>(
      () => UserRepository(local: sl<IUserLocalDataSource>()),
    );
    sl.registerLazySingleton<IContactsRepository>(
      () => ContactsRepository(local: sl<IContactsLocalDataSource>()),
    );
  }

  void _registerCubits() {
    sl.registerFactory(
      () => AppBloc(
        authRepository: sl<IAuthRepository>(),
        userRepository: sl<IUserRepository>(),
      ),
    );
    sl.registerFactory(
      () => AuthBloc(
        authRepository: sl<IAuthRepository>(),
        userRepository: sl<IUserRepository>(),
        securityService: sl<SecurityService>(),
        biometricAuthService: sl<BiometricAuthService>(),
      ),
    );
    sl.registerFactory(
      () => RegisterUserFormBloc(
        userRepository: sl<IUserRepository>(),
        authRepository: sl<IAuthRepository>(),
        securityService: sl<SecurityService>(),
      ),
    );

    sl.registerFactory(
      () => UserDetailsBloc(
        authRepository: sl<IAuthRepository>(),
        userRepository: sl<IUserRepository>(),
        imagePickerService: sl<ImagePickerService>(),
      ),
    );
    sl.registerFactory(
      () => ContactListBloc(
        authRepository: sl<IAuthRepository>(),
        contactsRepository: sl<IContactsRepository>(),
      ),
    );
    sl.registerFactory(
      () => RegisterContactFormBloc(
        authRepository: sl<IAuthRepository>(),
        contactsRepository: sl<IContactsRepository>(),
      ),
    );
  }

  Future<void> _registerCore() async {
    final localStorageService = LocalStorageService();
    await localStorageService.init();
    sl.registerSingleton<LocalStorageService>(localStorageService);
    sl.registerSingleton(ImagePickerService());
    sl.registerSingleton(BiometricAuthService());
    final keyString = dotenv.env['KEY_STRING']!;
    final ivString = dotenv.env['IV_STRING']!;
    sl.registerSingleton(SecurityService(keyString, ivString));
  }
}
