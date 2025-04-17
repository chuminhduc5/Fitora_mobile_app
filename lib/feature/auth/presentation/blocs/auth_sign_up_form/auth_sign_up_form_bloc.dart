import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/sign_up_form_data.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/sign_up_form_input_data.dart';
import 'package:meta/meta.dart';

part 'auth_sign_up_form_event.dart';

part 'auth_sign_up_form_state.dart';

class AuthSignUpFormBloc
    extends Bloc<AuthSignUpFormEvent, AuthSignUpFormState> {
  AuthSignUpFormBloc() : super(const AuthSignUpFormInitialState()) {
    on<SignUpFormEmailChangedEvent>(_emailChanged);
    on<SignUpFormUsernameChangedEvent>(_usernameChanged);
    on<SignUpFormPasswordChangedEvent>(_passwordChanged);
    on<SignUpFormConfirmPasswordChangedEvent>(_confirmPasswordChanged);
  }

  // Thay đổi Email - Bloc
  Future<void> _emailChanged(
    SignUpFormEmailChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = SignUpFormInputData(
      inputEmail: event.email,
      inputUsername: state.data.username,
      inputPassword: state.data.password,
      inputConfirmPassword: state.data.confirmPassword,
      inputIsValid: inputValidator(
        event.email,
        state.data.username,
        state.data.password,
        state.data.confirmPassword,
      ),
    );
    emit(AuthSignUpFormInputDataState(updateData));
  }

  // Thay đổi Username - Bloc
  Future<void> _usernameChanged(
    SignUpFormUsernameChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = SignUpFormInputData(
      inputEmail: state.data.email,
      inputUsername: event.username,
      inputPassword: state.data.password,
      inputConfirmPassword: state.data.confirmPassword,
      inputIsValid: inputValidator(
        state.data.email,
        event.username,
        state.data.password,
        state.data.confirmPassword,
      ),
    );
    emit(AuthSignUpFormInputDataState(updateData));
  }

  // Thay đổi Password - Bloc
  Future<void> _passwordChanged(
    SignUpFormPasswordChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = SignUpFormInputData(
      inputEmail: state.data.email,
      inputUsername: state.data.username,
      inputPassword: event.password,
      inputConfirmPassword: state.data.confirmPassword,
      inputIsValid: inputValidator(
        state.data.email,
        state.data.username,
        event.password,
        state.data.confirmPassword,
      ),
    );
    emit(AuthSignUpFormInputDataState(updateData));
  }

  // Thay đổi ConfirmPassword - Bloc
  Future<void> _confirmPasswordChanged(
    SignUpFormConfirmPasswordChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = SignUpFormInputData(
      inputEmail: state.data.email,
      inputUsername: state.data.username,
      inputPassword: state.data.password,
      inputConfirmPassword: event.confirmPassword,
      inputIsValid: inputValidator(
        state.data.email,
        state.data.username,
        state.data.password,
        event.confirmPassword,
      ),
    );
    emit(AuthSignUpFormInputDataState(updateData));
  }

  bool inputValidator(
    String email,
    String username,
    String password,
    String confirmPassword,
  ) {
    if (username.isEmpty) {
      return false;
    }

    if (email.isEmpty) {
      return false;
    }

    if (password.length < 6 && confirmPassword.length < 6) {
      return false;
    }

    if (!password.isPasswordValid || !confirmPassword.isPasswordValid) {
      return false;
    }

    if (password != confirmPassword) {
      logg.i("Trạng thái false");
      return false;
    }

    return true;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AuthSignUpFormBloc =====");
    return super.close();
  }
}
