import 'package:contacts_app_re014/core/domain/error_handler/failures/failures.dart';
import 'package:contacts_app_re014/core/domain/error_handler/message/messages.dart';

class GenericFailure extends Failure {
  @override
  final message = GenericFails();

  @override
  bool operator ==(Object other) => identical(this, other) || other is GenericFailure;

  @override
  int get hashCode => super.hashCode ^ message.hashCode;

  @override
  List<Object> get props => [message];
}
