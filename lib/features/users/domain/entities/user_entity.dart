import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String? avatar;

  const UserEntity({
    required this.name,
    required this.email,
    required this.password,
    this.avatar,
  });

  UserEntity copyWith({
    String? name,
    String? email,
    String? password,
    String? avatar,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        avatar,
      ];
}
