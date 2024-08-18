import 'package:bloc/bloc.dart';
import 'package:contacts_app_re014/core/domain/validators.dart';
import 'package:contacts_app_re014/features/auth/domain/repositories/auth_repository.dart';
import 'package:contacts_app_re014/features/users/domain/core/register_status.dart';
import 'package:contacts_app_re014/features/users/domain/index.dart';
import 'package:contacts_app_re014/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterUserFormBloc extends Bloc<RegisterUserFormEvent, RegisterUserFormState> {
  RegisterUserFormBloc({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const RegisterUserFormState()) {
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<ConfirmPasswordUnfocused>(_onConfirmPasswordUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  void _onNameChanged(NameChanged event, Emitter<RegisterUserFormState> emit) {
    final isValid = AppValidators.nameValidator(event.name);
    emit(
      state.copyWith(
        name: event.name,
        isValid: isValid,
        status: RegisterUserStatus.inProgress,
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterUserFormState> emit) {
    final isValid = AppValidators.emailValidator(event.email);
    emit(
      state.copyWith(
        email: event.email,
        isValid: isValid,
        status: RegisterUserStatus.inProgress,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterUserFormState> emit) {
    final isValid = AppValidators.passwordValidator(event.password);
    emit(
      state.copyWith(
        email: event.password,
        isValid: isValid,
        status: RegisterUserStatus.inProgress,
      ),
    );
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<RegisterUserFormState> emit) {
    final isValid = AppValidators.emailValidator(state.email);
    emit(
      state.copyWith(
        email: state.email,
        isValid: isValid,
        status: RegisterUserStatus.inProgress,
      ),
    );
  }

  void _onPasswordUnfocused(
    PasswordUnfocused event,
    Emitter<RegisterUserFormState> emit,
  ) {
    final isValid = AppValidators.passwordValidator(state.password);
    emit(
      state.copyWith(
        email: state.password,
        isValid: isValid,
        status: RegisterUserStatus.inProgress,
      ),
    );
  }

  void _onConfirmPasswordUnfocused(
    ConfirmPasswordUnfocused event,
    Emitter<RegisterUserFormState> emit,
  ) {
    final isValid = event.password == state.password;
    emit(
      state.copyWith(
        email: state.password,
        isValid: isValid,
        status: RegisterUserStatus.inProgress,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<RegisterUserFormState> emit,
  ) async {
    final emailOk = AppValidators.emailValidator(state.email);
    final passwordOk = AppValidators.passwordValidator(state.password);
    final isValid = emailOk && passwordOk;
    emit(
      state.copyWith(
        email: state.email,
        password: state.password,
        isValid: isValid,
        status: isValid ? RegisterUserStatus.submitting : RegisterUserStatus.fail,
      ),
    );

    final resp = await _userRepository.addUser(
      user: UserEntity(
        name: state.name,
        email: state.email,
        password: state.password,
      ),
    );

    resp.fold((l) {
      emit(
        state.copyWith(
          isValid: false,
          status: RegisterUserStatus.fail,
        ),
      );
    }, (r) async {
      emit(
        state.copyWith(
          isValid: true,
          status: RegisterUserStatus.success,
        ),
      );
      final resp = await _authRepository.login(email: state.email, password: state.password);
      resp.fold((l) async {
        await _userRepository.deleteUser(email: state.email);
        emit(
          state.copyWith(
            isValid: false,
            status: RegisterUserStatus.fail,
          ),
        );
      }, (r) async {
        emit(
          state.copyWith(
            isValid: true,
            status: RegisterUserStatus.success,
          ),
        );
      });
    });
  }
}
