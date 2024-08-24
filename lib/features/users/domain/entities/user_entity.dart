import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String? avatar;

  const UserEntity({
    required this.name,
    required this.email,
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
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        avatar,
      ];
}
