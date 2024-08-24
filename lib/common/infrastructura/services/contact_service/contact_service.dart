import 'package:flutter_contacts/flutter_contacts.dart';

class ContactService {
  Future<bool> requestPermission() async {
    return await FlutterContacts.requestPermission();
  }

  Future<List<Contact>> getContacts({bool withProperties = true}) async {
    if (await requestPermission()) {
      return await FlutterContacts.getContacts(
        withProperties: withProperties,
      );
    } else {
      throw Exception('Contacts Access denied');
    }
  }

  Future<Contact?> getContactById(String id) async {
    if (await requestPermission()) {
      return await FlutterContacts.getContact(id);
    } else {
      throw Exception('Contacts Access denied');
    }
  }

  Future<void> createContact(Contact contact) async {
    if (await requestPermission()) {
      await contact.insert();
    } else {
      throw Exception('Contacts Access denied');
    }
  }

  Future<void> updateContact(Contact contact) async {
    if (await requestPermission()) {
      await contact.update();
    } else {
      throw Exception('Contacts Access denied');
    }
  }

  Future<void> deleteContact(Contact contact) async {
    if (await requestPermission()) {
      await contact.delete();
    } else {
      throw Exception('Contacts Access denied');
    }
  }
}
