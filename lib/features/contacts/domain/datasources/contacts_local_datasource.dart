import 'package:contacts_app_re014/features/contacts/infrastructure/dtos/index.dart';

abstract class IContactsLocalDataSource {
  Future<ContactDto> getContact({required String id});
  Future<List<ContactDto>> getContacts({required String userEmail});
  Future<void> addContact({required ContactDto contact});
  Future<void> removeContact({required ContactDto contact});
}
