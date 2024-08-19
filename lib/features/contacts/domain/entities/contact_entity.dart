import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String id;
  final String name;
  final String userEmail;

  const ContactEntity({
    required this.id,
    required this.name,
    required this.userEmail,
  });

  ContactEntity copyWith({
    String? id,
    String? name,
    String? userEmail,
  }) {
    return ContactEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        userEmail,
      ];
}
