import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/common/index.dart';
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
    required ContactService contactService,
  })  : _authRepository = authRepository,
        _contactsRepository = contactsRepository,
        _contactService = contactService,
        super(const RegisterContactFormState()) {
    on<FormSubmitted>(_onFormSubmitted);
  }

  final IAuthRepository _authRepository;
  final IContactsRepository _contactsRepository;
  final ContactService _contactService;

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<RegisterContactFormState> emit) async {
    emit(state.copyWith(status: RegisterContactStatus.submitting));
    if (!event.fromApp) {
      final tmp = await _contactService.getContactById(event.id!);
      if (tmp != null) {
        tmp.name.first = event.name;
        tmp.phones[0].number = event.phoneNumber;

        await _contactService.updateContact(tmp);
        emit(state.copyWith(status: RegisterContactStatus.success));
      } else {
        emit(state.copyWith(status: RegisterContactStatus.fail));
      }
    } else {
      final respSession = await _authRepository.getSession();
      await respSession.fold(
        (l) {},
        (email) async {
          final contactsResp = await _contactsRepository.getContacts(userEmail: email);
          await contactsResp.fold(
            (l) {},
            (contacts) async {
              final idInUse = contacts.any((e) => e.phoneNumber == event.phoneNumber);
              if (idInUse) {
                emit(state.copyWith(status: RegisterContactStatus.idInUse));
              } else {
                final resp = await _contactsRepository.addContact(
                  contact: ContactEntity(
                    id: event.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                    phoneNumber: event.phoneNumber,
                    name: event.name,
                    userEmail: email,
                    fromApp: true,
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
}
