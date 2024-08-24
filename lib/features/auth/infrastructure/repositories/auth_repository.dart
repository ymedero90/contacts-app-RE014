import 'package:contacts_app_re014/common/domain/error_handler/error_handling.dart';
import 'package:contacts_app_re014/common/domain/error_handler/failures/fail_with_message.dart';
import 'package:contacts_app_re014/common/domain/error_handler/failures/failures.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/auth/index.dart';
import 'package:dartz/dartz.dart';

class AuthRepository with ErrorHandling<Failure> implements IAuthRepository {
  final IAuthLocalDataSource local;

  AuthRepository({required this.local});

  @override
  Future<Either<Failure, void>> login({required String email}) {
    return process<void>(
      action: () async {
        await local.setSession(email: email);
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, void>> logout({required String email}) {
    return process<void>(
      action: () async {
        await local.logout();
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, String>> getSession() {
    return process<String>(
      action: () async {
        final response = await local.getSession();
        return response;
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, AuthDataEntity>> getCredentials({required String email}) {
    return process<AuthDataEntity>(
      action: () async {
        final response = await local.getCredentials(email: email);
        return response.toDomain();
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, void>> registerCredentials({required AuthDataEntity data}) {
    return process<void>(
      action: () async {
        await local.registerCredentials(data: AuthDataDto.fromDomain(data));
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }
}
