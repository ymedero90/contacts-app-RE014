import 'package:contacts_app_re014/features/users/domain/entities/user_entity.dart';

class UserDto {
  final String name;
  final String email;
  final String? avatar;

  UserDto({
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory UserDto.fromDomain(UserEntity user) {
    return UserDto(
      name: user.name,
      email: user.email,
      avatar: user.avatar,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      name: name,
      email: email,
      avatar: avatar,
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
