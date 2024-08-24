import 'package:contacts_app_re014/common/domain/error_handler/failures/failures.dart';
import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IContactsRepository {
  Future<Either<Failure, List<ContactEntity>>> getContacts({required String userEmail});
  Future<Either<Failure, ContactEntity>> getContact({required String id});
  Future<Either<Failure, void>> addContact({required ContactEntity contact});
  Future<Either<Failure, void>> removeContact({required ContactEntity contact});
}
