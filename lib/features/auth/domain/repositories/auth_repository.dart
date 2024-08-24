import 'package:contacts_app_re014/common/domain/error_handler/failures/failures.dart';
import 'package:contacts_app_re014/features/auth/index.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, void>> login({required String email});
  Future<Either<Failure, void>> logout({required String email});
  Future<Either<Failure, String>> getSession();

  Future<Either<Failure, void>> registerCredentials({required AuthDataEntity data});
  Future<Either<Failure, AuthDataEntity>> getCredentials({required String email});
}
