import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/users/domain/datasources/user_local_datasource.dart';
import 'package:contacts_app_re014/features/users/domain/entities/user_entity.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:contacts_app_re014/features/users/infrastructure/dtos/index.dart';
import 'package:dartz/dartz.dart';

class UserRepository with ErrorHandling<Failure> implements IUserRepository {
  final IUserLocalDataSource local;

  UserRepository({required this.local});

  @override
  Future<Either<Failure, void>> addUser({required UserEntity user}) {
    return process<void>(
      action: () async {
        await local.addUser(user: UserDto.fromDomain(user));
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getUser({required String email}) {
    return process<UserEntity>(
      action: () async {
        UserDto response = await local.getUser(email: email);
        final data = response.toDomain();
        return data;
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() {
    return process<List<UserEntity>>(
      action: () async {
        List<UserDto> response = await local.getUsers();
        final data = response.map((e) => e.toDomain()).toList();
        return data;
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, void>> deleteUser({required String email}) {
    return process<void>(
      action: () async {
        await local.deleteUser(email: email);
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }
}
