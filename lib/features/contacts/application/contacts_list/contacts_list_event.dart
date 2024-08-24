part of 'contacts_list_bloc.dart';

sealed class ContactsListEvent extends Equatable {
  const ContactsListEvent();

  @override
  List<Object> get props => [];
}

final class OnGetContactsEvent extends ContactsListEvent {
  final String? filter;

  const OnGetContactsEvent({this.filter});
}

final class OnSaveContactEvent extends ContactsListEvent {
  final ContactEntity contact;

  const OnSaveContactEvent({required this.contact});
}

final class OnRemoveContactEvent extends ContactsListEvent {
  final ContactEntity contact;

  const OnRemoveContactEvent({required this.contact});
}
