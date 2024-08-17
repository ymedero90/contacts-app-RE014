import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';

class ContactDto {
  final String name;
  final String id;

  ContactDto({
    required this.name,
    required this.id,
  });

  factory ContactDto.fromDomain(ContactEntity contact) {
    return ContactDto(
      name: contact.name,
      id: contact.id,
    );
  }

  ContactEntity toDomain() {
    return ContactEntity(
      name: name,
      id: id,
    );
  }

  factory ContactDto.fromJson(Map<String, dynamic> json) {
    return ContactDto(
      name: json['name'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
