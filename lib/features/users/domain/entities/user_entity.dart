class UserEntity {
  final String name;
  final String email;
  final String password;
  final String? avatar;

  UserEntity({
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
}
