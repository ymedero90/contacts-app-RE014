import 'package:contacts_app_re014/core/index.dart';
import 'package:contacts_app_re014/core/infrastructura/services/local_storage_service/local_storage_service.dart';
import 'package:contacts_app_re014/features/auth/domain/datasources/index.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/auth/infrastructure/datasource/auth_local_datasource.dart';
import 'package:contacts_app_re014/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/contacts/domain/datasources/contacts_local_datasource.dart';
import 'package:contacts_app_re014/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:contacts_app_re014/features/contacts/infrastructure/datasource/contacts_local_datasource.dart';
import 'package:contacts_app_re014/features/contacts/infrastructure/repositories/contacts_repository.dart';
import 'package:contacts_app_re014/features/users/domain/datasources/user_local_datasource.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:contacts_app_re014/features/users/infrastructure/datasource/user_local_datasource.dart';
import 'package:contacts_app_re014/features/users/infrastructure/index.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._init() {
    _registerCore();
    _registerDataSourceLayer();
    _registerRepositoryLayer();
    _registerCubits();
  }

  static Injector? instance;

  static GetIt sl = GetIt.instance;

  static late String apiBaseUrl;

  T getDependency<T extends Object>() => sl.get();

  static void onInit() {
    instance ??= Injector._init();
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
      () => ContactsRepository(local: sl<ContactsLocalDataSource>()),
    );
  }

  void _registerCubits() {
    // sl.registerSingleton(
    //   SplashCubit(
    //     appRepository: sl<IAppRepository>(),
    //     secureStorageManager: sl<SecureStorageManager>(),
    //     userProfileRepository: sl<IUserProfileRepository>(),
    //   ),
    // );
  }

  Future<void> _registerCore() async {
    sl.registerSingleton(LocalStorageService());
    sl.registerSingleton(ImagePickerService());
  }
}

class SharedPreferences {}
