import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/common/domain/validators.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/contacts/domain/core/register_status.dart';
import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';
import 'package:contacts_app_re014/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'contact_register_event.dart';
part 'contact_register_state.dart';

class RegisterUserFormBloc extends Bloc<RegisterContactFormEvent, RegisterContactFormState> {
  RegisterUserFormBloc({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
    required IContactsRepository contactsRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _contactsRepository = contactsRepository,
        super(const RegisterContactFormState()) {
    on<NameChanged>(_onNameChanged);
    on<IdChanged>(_onIdChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final IContactsRepository _contactsRepository;

  void _onNameChanged(NameChanged event, Emitter<RegisterContactFormState> emit) {
    emit(
      state.copyWith(
        name: event.name,
        status: RegisterContactStatus.inProgress,
      ),
    );
  }

  void _onIdChanged(IdChanged event, Emitter<RegisterContactFormState> emit) {
    emit(
      state.copyWith(
        id: event.id,
        status: RegisterContactStatus.inProgress,
      ),
    );
  }

  Future<void> _onFormSubmitted(FormSubmitted event, Emitter<RegisterContactFormState> emit) async {
    final idError = AppValidators.emailValidator(state.id);
    final passwordError = AppValidators.passwordValidator(state.name);
    final isValid = idError == null && passwordError == null;
    emit(
      state.copyWith(
        id: state.id,
        name: state.name,
        isValid: isValid,
        status: isValid ? RegisterContactStatus.submitting : RegisterContactStatus.fail,
      ),
    );
    final respSession = await _authRepository.getSession();
    respSession.fold((l) {}, (email) async {
      final resp = await _contactsRepository.addContact(
        contact: ContactEntity(
          id: state.id,
          name: state.name,
          userEmail: email,
        ),
      );

      resp.fold((l) {
        emit(
          state.copyWith(
            isValid: false,
            status: RegisterContactStatus.fail,
          ),
        );
      }, (r) async {
        emit(
          state.copyWith(
            isValid: true,
            status: RegisterContactStatus.success,
          ),
        );
      });
    });
  }
}
