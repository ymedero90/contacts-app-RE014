class ContactEntity {
  final String name;
  final String id;

  ContactEntity({
    required this.name,
    required this.id,
  });

  ContactEntity copyWith({
    String? name,
    String? id,
  }) {
    return ContactEntity(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
