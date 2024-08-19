import 'package:contacts_app_re014/common/domain/error_handler/failures/failures.dart';
import 'package:contacts_app_re014/common/domain/error_handler/message/messages.dart';

class FailWithMessage extends Failure {
  @override
  final IMessage message;

  const FailWithMessage({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
