import 'package:contacts_app_re014/common/domain/error_handler/message/messages.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  IMessage get message;
}
