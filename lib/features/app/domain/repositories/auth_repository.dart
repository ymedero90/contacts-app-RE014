import 'package:contacts_app_re014/common/domain/error_handler/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout({required String email});
  Future<Either<Failure, String>> getSession();
}
