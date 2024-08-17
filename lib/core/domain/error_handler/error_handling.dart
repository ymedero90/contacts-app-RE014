import 'package:contacts_app_re014/core/domain/error_handler/message/messages.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

typedef ActionCallback<T> = Future<T> Function();
typedef ParseException<T> = T Function(dynamic ex);
mixin ErrorHandling<F> {
  Future<Either<F, T>> process<T>({
    required ActionCallback<T> action,
    required ParseException<F> onFail,
  }) async {
    final logger = Logger();
    try {
      final result = await action();
      return right(result);
    } catch (e, trace) {
      if (e is HiveError) {
        logger.e('EXCEPTION: ${e.message}', stackTrace: trace);
        return left(onFail(ErrorMessage(e.message, "Hive Error", null, null)));
      } else {
        return left(onFail(ErrorMessage(e.toString(), "Error", null, null)));
      }
    }
  }
}
