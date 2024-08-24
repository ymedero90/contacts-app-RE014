import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';

class ContactDto {
  final String id;
  final bool fromApp;
  final String phoneNumber;
  final String name;
  final String userEmail;

  ContactDto({
    required this.id,
    required this.phoneNumber,
    this.fromApp = false,
    required this.name,
    required this.userEmail,
  });

  factory ContactDto.fromDomain(ContactEntity contact) {
    return ContactDto(
      id: contact.id,
      phoneNumber: contact.phoneNumber,
      fromApp: contact.fromApp,
      name: contact.name,
      userEmail: contact.userEmail,
    );
  }

  ContactEntity toDomain() {
    return ContactEntity(
      id: id,
      phoneNumber: phoneNumber,
      fromApp: fromApp,
      name: name,
      userEmail: userEmail,
    );
  }

  factory ContactDto.fromJson(Map<String, dynamic> json) {
    return ContactDto(
      id: json['id'] as String,
      name: json['name'] as String,
      fromApp: json['fromApp'] as bool,
      userEmail: json['userEmail'] as String,
      phoneNumber: (json['phoneNumber'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userEmail': userEmail,
      'fromApp': fromApp,
      'phoneNumber': phoneNumber,
    };
  }
}
