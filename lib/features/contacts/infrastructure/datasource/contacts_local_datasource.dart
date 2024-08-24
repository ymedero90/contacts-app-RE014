import 'dart:convert';

import 'package:contacts_app_re014/common/domain/error_handler/message/messages.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/constants.dart';
import 'package:contacts_app_re014/common/infrastructura/services/local_storage_service/local_storage_service.dart';
import 'package:contacts_app_re014/features/contacts/domain/datasources/contacts_local_datasource.dart';
import 'package:contacts_app_re014/features/contacts/infrastructure/dtos/contact_dto.dart';

class ContactsLocalDataSource implements IContactsLocalDataSource {
  final LocalStorageService localStorageService;

  ContactsLocalDataSource({required this.localStorageService});

  @override
  Future<void> addContact({required ContactDto contact}) async {
    final exist = await localStorageService.get(contact.id, LocalBoxes.ContactsBox);
    if (exist != null) {
      await removeContact(contact: contact);
    }
    final data = json.encode(contact.toJson());
    await localStorageService.put(
      contact.id,
      data,
      LocalBoxes.ContactsBox,
    );
  }

  @override
  Future<ContactDto> getContact({required String id}) async {
    final data = await localStorageService.get(id, LocalBoxes.ContactsBox);
    if (data != null) {
      final decoded = json.decode(data);
      final response = ContactDto.fromJson(decoded);
      return response;
    }
    throw Exception(const ResourceNotFound());
  }

  @override
  Future<List<ContactDto>> getContacts({required String userEmail}) async {
    final data = await localStorageService.getAll(LocalBoxes.ContactsBox);
    final decoded = data.map((e) => json.decode(e)).toList();
    final response = decoded.map((e) => ContactDto.fromJson(e)).toList();
    return response;
  }

  @override
  Future<void> removeContact({required ContactDto contact}) async {
    await localStorageService.delete(
      contact.id,
      LocalBoxes.ContactsBox,
    );
  }
}
