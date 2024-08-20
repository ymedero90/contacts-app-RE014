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
