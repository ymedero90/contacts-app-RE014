import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';
import 'package:contacts_app_re014/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:equatable/equatable.dart';

part 'contacts_list_event.dart';
part 'contacts_list_state.dart';

class UserDetailsBloc extends Bloc<ContactsListEvent, ContactsListState> {
  UserDetailsBloc({
    required IContactsRepository contactsRepository,
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        _contactsRepository = contactsRepository,
        super(const ContactsListState.initail()) {
    on<OnGetContactsEvent>(_onGetContactsEvent);
  }

  final IContactsRepository _contactsRepository;
  final IAuthRepository _authRepository;

  Future<void> _onGetContactsEvent(
    OnGetContactsEvent event,
    Emitter<ContactsListState> emit,
  ) async {
    final respSession = await _authRepository.getSession();
    respSession.fold((l) {
      emit(ContactsListState.fail(l.message.body));
    }, (email) async {
      final respUser = await _contactsRepository.getContacts(userEmail: email);
      respUser.fold((l) {}, (contacts) {
        emit(ContactsListState.fetched(contacts));
      });
    });
  }
}
