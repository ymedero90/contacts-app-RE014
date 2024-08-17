import 'package:equatable/equatable.dart';

enum MessageType { ERROR, WARNING, INFO, SUCCESS }

abstract class IMessage {
  MessageType get type;
  String get title;
  String get body;
  dynamic get data;
}

class WrongCredentials extends Equatable implements IMessage {
  const WrongCredentials();

  @override
  MessageType get type => MessageType.ERROR;

  @override
  String get body => 'The email or password is incorrect.';

  @override
  String get title => 'Sign in';

  @override
  List<Object> get props => [title, body, type];

  @override
  get data => throw UnimplementedError();
}

class GenericFails implements IMessage {
  @override
  MessageType get type => MessageType.ERROR;

  @override
  String get body => 'Sorry, something was wrong at the time of processing your request. Please, try again.';

  @override
  String get title => 'Generic';

  @override
  get data => throw UnimplementedError();
}

class ErrorMessage implements IMessage {
  ErrorMessage(
    this._body,
    this._title,
    this._code,
    this._data,
  );
  final String _body;
  final String _title;
  // ignore: unused_field
  final int? _code;
  final dynamic _data;

  @override
  String get title => _title;

  @override
  MessageType get type => MessageType.ERROR;

  @override
  String get body => _body;

  @override
  dynamic get data => _data;
}
