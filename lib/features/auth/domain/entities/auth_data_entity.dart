class AuthDataEntity {
  final String email;
  final String password;
  final bool allowBiometric;
  final bool firstLoggin;

  AuthDataEntity({
    required this.email,
    required this.password,
    this.allowBiometric = false,
    this.firstLoggin = true,
  });

  AuthDataEntity copyWith({
    String? email,
    String? password,
    bool? allowBiometric,
    bool? firstLoggin,
  }) {
    return AuthDataEntity(
      email: email ?? this.email,
      password: password ?? this.password,
      allowBiometric: allowBiometric ?? this.allowBiometric,
      firstLoggin: firstLoggin ?? this.firstLoggin,
    );
  }
}
