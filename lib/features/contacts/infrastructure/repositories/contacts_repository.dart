import 'package:contacts_app_re014/core/domain/error_handler/error_handling.dart';
import 'package:contacts_app_re014/core/domain/error_handler/failures/fail_with_message.dart';
import 'package:contacts_app_re014/core/domain/error_handler/failures/failures.dart';
import 'package:contacts_app_re014/features/contacts/domain/datasources/contacts_local_datasource.dart';
import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';
import 'package:contacts_app_re014/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:contacts_app_re014/features/contacts/infrastructure/dtos/contact_dto.dart';
import 'package:dartz/dartz.dart';

class ContactRepository with ErrorHandling<Failure> implements IContactsRepository {
  final IContactsLocalDataSource local;

  ContactRepository({required this.local});

  @override
  Future<Either<Failure, void>> addContact({required ContactEntity contact}) {
    return process<void>(
      action: () async {
        await local.addContact(contact: ContactDto.fromDomain(contact));
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, ContactEntity>> getContact({required String id}) {
    return process<ContactEntity>(
      action: () async {
        ContactDto response = await local.getContact(id: id);
        final data = response.toDomain();
        return data;
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> getContacts({required String userEmail}) {
    return process<List<ContactEntity>>(
      action: () async {
        List<ContactDto> response = await local.getContacts(userEmail: userEmail);
        final data = response.map((e) => e.toDomain()).toList();
        final filtered = data.where((e) => e.userEmail == userEmail).toList();
        return filtered;
      },
      onFail: (message) => FailWithMessage(message: message),
    );
  }
}
