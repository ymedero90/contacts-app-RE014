import 'package:contacts_app_re014/common/domain/error_handler/failures/failures.dart';
import 'package:contacts_app_re014/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IUserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, UserEntity>> getUser({required String email});
  Future<Either<Failure, void>> deleteUser({required String email});
  Future<Either<Failure, void>> addUser({required UserEntity user});
}
