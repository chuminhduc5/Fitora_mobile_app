import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/sign_in_form_data.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/sign_in_form_input_data.dart';
import 'package:meta/meta.dart';

part 'auth_sign_in_form_event.dart';

part 'auth_sign_in_form_state.dart';

class AuthSignInFormBloc
    extends Bloc<AuthSignInFormEvent, AuthSignInFormState> {
  AuthSignInFormBloc() : super(const AuthSignInFormInitialState()) {
    on<AuthSignInFormEmailChangedEvent>(_emailChanged);
    on<AuthSignInFormPasswordChangedEvent>(_passwordChanged);
  }

  // Thay đổi Email - Bloc
  Future<void> _emailChanged(
    AuthSignInFormEmailChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = SignInFormInputData(
      inputEmail: event.email,
      inputPassword: state.data.password,
      inputIsValid: inputValidator(event.email, state.data.password),
    );
    emit(AuthSignInFormDataState(updateData));
  }

  // Thay đổi Password - Bloc
  Future<void> _passwordChanged(
    AuthSignInFormPasswordChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = SignInFormInputData(
      inputEmail: state.data.email,
      inputPassword: event.password,
      inputIsValid: inputValidator(state.data.email, event.password),
    );
    emit(AuthSignInFormDataState(updateData));
  }

  bool inputValidator(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AuthSignInFormBloc =====");
    return super.close();
  }
}
