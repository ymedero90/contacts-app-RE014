import 'package:contacts_app_re014/features/auth/domain/entities/auth_data_entity.dart';

class AuthDataDto {
  final String email;
  final String password;
  final bool allowBiometric;
  final bool firstLoggin;

  AuthDataDto({
    required this.email,
    required this.password,
    this.allowBiometric = false,
    this.firstLoggin = true,
  });

  factory AuthDataDto.fromDomain(AuthDataEntity data) {
    return AuthDataDto(
      email: data.email,
      password: data.password,
      allowBiometric: data.allowBiometric,
      firstLoggin: data.firstLoggin,
    );
  }

  AuthDataEntity toDomain() {
    return AuthDataEntity(
      email: email,
      password: password,
      allowBiometric: allowBiometric,
      firstLoggin: firstLoggin,
    );
  }

  factory AuthDataDto.fromJson(Map<String, dynamic> json) {
    return AuthDataDto(
      email: json['email'] as String,
      password: json['password'] as String,
      allowBiometric: json['allowBiometric'] as bool,
      firstLoggin: json['firstLoggin'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'allowBiometric': allowBiometric,
      'firstLoggin': firstLoggin,
    };
  }
}
