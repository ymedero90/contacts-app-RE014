part of 'contacts_list_bloc.dart';

class ContactsListState extends Equatable {
  const ContactsListState._({this.contacts = const [], this.error});

  const ContactsListState.initail() : this._();

  const ContactsListState.fetched(List<ContactEntity> contacts) : this._(contacts: contacts);

  const ContactsListState.fail(String? error) : this._(error: error);

  final List<ContactEntity> contacts;
  final String? error;

  @override
  List<Object?> get props => [contacts, error];
}
