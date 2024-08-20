import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/contacts/domain/core/register_contacts_status.dart';
import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';
import 'package:contacts_app_re014/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:equatable/equatable.dart';

part 'contact_register_event.dart';
part 'contact_register_state.dart';

class RegisterContactFormBloc extends Bloc<RegisterContactFormEvent, RegisterContactFormState> {
  RegisterContactFormBloc({
    required IAuthRepository authRepository,
    required IContactsRepository contactsRepository,
  })  : _authRepository = authRepository,
        _contactsRepository = contactsRepository,
        super(const RegisterContactFormState()) {
    on<FormSubmitted>(_onFormSubmitted);
  }

  final IAuthRepository _authRepository;
  final IContactsRepository _contactsRepository;

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<RegisterContactFormState> emit) async {
    emit(state.copyWith(status: RegisterContactStatus.submitting));
    final respSession = await _authRepository.getSession();
    await respSession.fold(
      (l) {},
      (email) async {
        final contactsResp = await _contactsRepository.getContacts(userEmail: email);
        await contactsResp.fold(
          (l) {},
          (contacts) async {
            final idInUse = contacts.any((e) => e.id == event.id);
            if (idInUse) {
              emit(state.copyWith(status: RegisterContactStatus.idInUse));
            } else {
              final resp = await _contactsRepository.addContact(
                contact: ContactEntity(
                  id: event.id,
                  name: event.name,
                  userEmail: email,
                ),
              );

              resp.fold((l) {
                emit(state.copyWith(status: RegisterContactStatus.fail));
              }, (r) async {
                emit(state.copyWith(status: RegisterContactStatus.success));
              });
            }
          },
        );
      },
    );
  }
}
