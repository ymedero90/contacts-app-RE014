import 'package:contacts_app_re014/features/users/domain/entities/user_entity.dart';

class UserDto {
  final String name;
  final String email;
  final String password;
  final String? avatar;

  UserDto({
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
  });

  factory UserDto.fromDomain(UserEntity user) {
    return UserDto(
      name: user.name,
      email: user.email,
      password: user.password,
      avatar: user.avatar,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      name: name,
      email: email,
      password: password,
      avatar: avatar,
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      avatar: json['avatar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }
}
