part of 'contacts_list_bloc.dart';

class ContactsListState extends Equatable {
  const ContactsListState._({this.contacts = const [], this.status = RegisterListtStatus.loading});

  const ContactsListState.initail() : this._();

  const ContactsListState.fetched(List<ContactEntity> contacts)
      : this._(contacts: contacts, status: RegisterListtStatus.success);

  const ContactsListState.savingContact(RegisterListtStatus status) : this._(status: status);

  const ContactsListState.fail(String? error) : this._(status: RegisterListtStatus.fail);

  final List<ContactEntity> contacts;
  final RegisterListtStatus status;

  @override
  List<Object?> get props => [contacts, status];
}
