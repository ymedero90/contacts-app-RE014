import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';

class ContactDto {
  final String id;
  final String name;
  final String userEmail;

  ContactDto({
    required this.id,
    required this.name,
    required this.userEmail,
  });

  factory ContactDto.fromDomain(ContactEntity contact) {
    return ContactDto(
      id: contact.id,
      name: contact.name,
      userEmail: contact.userEmail,
    );
  }

  ContactEntity toDomain() {
    return ContactEntity(
      id: id,
      name: name,
      userEmail: userEmail,
    );
  }

  factory ContactDto.fromJson(Map<String, dynamic> json) {
    return ContactDto(
      id: json['id'] as String,
      name: json['name'] as String,
      userEmail: json['userEmail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userEmail': userEmail,
    };
  }
}
