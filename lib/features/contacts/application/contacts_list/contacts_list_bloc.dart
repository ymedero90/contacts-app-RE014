import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/contacts/domain/core/register_list_status.dart';
import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';
import 'package:contacts_app_re014/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:equatable/equatable.dart';

part 'contacts_list_event.dart';
part 'contacts_list_state.dart';

class ContactListBloc extends Bloc<ContactsListEvent, ContactsListState> {
  ContactListBloc({
    required IContactsRepository contactsRepository,
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        _contactsRepository = contactsRepository,
        super(const ContactsListState.initail()) {
    on<OnGetContactsEvent>(_onGetContactsEvent);
    add(const OnGetContactsEvent());
  }

  final IContactsRepository _contactsRepository;
  final IAuthRepository _authRepository;

  Future<void> _onGetContactsEvent(
    OnGetContactsEvent event,
    Emitter<ContactsListState> emit,
  ) async {
    final respSession = await _authRepository.getSession();
    await respSession.fold((l) {
      emit(ContactsListState.fail(l.message.body));
    }, (email) async {
      final respUser = await _contactsRepository.getContacts(userEmail: email);
      respUser.fold((l) {}, (contacts) {
        contacts.sort((x, y) => x.name.compareTo(y.name));
        if (event.filter != null) {
          final filtered = contacts.where((e) => e.name.toLowerCase().contains(event.filter!.toLowerCase())).toList();
          emit(ContactsListState.fetched(filtered));
        } else {
          emit(ContactsListState.fetched(contacts));
        }
      });
    });
  }
}
