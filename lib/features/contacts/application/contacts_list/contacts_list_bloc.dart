import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/contacts/domain/core/register_list_status.dart';
import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';
import 'package:contacts_app_re014/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'contacts_list_event.dart';
part 'contacts_list_state.dart';

class ContactListBloc extends Bloc<ContactsListEvent, ContactsListState> {
  ContactListBloc({
    required IContactsRepository contactsRepository,
    required IAuthRepository authRepository,
    required ContactService contactService,
  })  : _authRepository = authRepository,
        _contactsRepository = contactsRepository,
        _contactService = contactService,
        super(const ContactsListState.initail()) {
    on<OnGetContactsEvent>(_onGetContactsEvent);
    on<OnSaveContactEvent>(_onSaveContactEvent);
    on<OnRemoveContactEvent>(_onRemoveContactEvent);
    add(const OnGetContactsEvent());
  }

  final IContactsRepository _contactsRepository;
  final IAuthRepository _authRepository;
  final ContactService _contactService;

  Future<void> _onGetContactsEvent(
    OnGetContactsEvent event,
    Emitter<ContactsListState> emit,
  ) async {
    final deviceContacts = await _contactService.getContacts();
    final deviceContactsFormated = deviceContacts
        .map((e) => ContactEntity(
              id: e.id,
              phoneNumber: e.phones.isNotEmpty ? e.phones[0].number : '',
              name: e.name.first,
              userEmail: e.emails.isNotEmpty ? e.emails[0].address : '',
            ))
        .toList();
    final respSession = await _authRepository.getSession();
    await respSession.fold((l) {
      emit(ContactsListState.fail(l.message.body));
    }, (email) async {
      final respUser = await _contactsRepository.getContacts(userEmail: email);
      respUser.fold((l) {}, (contacts) {
        contacts.sort((x, y) => x.name.compareTo(y.name));
        contacts.addAll(deviceContactsFormated);
        if (event.filter != null) {
          final filtered = contacts.where((e) => e.name.toLowerCase().contains(event.filter!.toLowerCase())).toList();
          emit(ContactsListState.fetched(filtered));
        } else {
          emit(ContactsListState.fetched(contacts));
        }
      });
    });
  }

  Future<void> _onSaveContactEvent(
    OnSaveContactEvent event,
    Emitter<ContactsListState> emit,
  ) async {
    emit(const ContactsListState.savingContact(RegisterListtStatus.loading));
    try {
      await _contactService.createContact(
        Contact(
          name: Name(first: event.contact.name, prefix: event.contact.name[0]),
          phones: [Phone(event.contact.phoneNumber)],
        ),
      );
      await _contactsRepository.removeContact(contact: event.contact);
      add(const OnGetContactsEvent());
    } catch (e) {
      emit(const ContactsListState.savingContact(RegisterListtStatus.savingFail));
    }
  }

  Future<void> _onRemoveContactEvent(
    OnRemoveContactEvent event,
    Emitter<ContactsListState> emit,
  ) async {
    emit(const ContactsListState.savingContact(RegisterListtStatus.loading));
    await _contactsRepository.removeContact(contact: event.contact);
    add(const OnGetContactsEvent());
  }
}
