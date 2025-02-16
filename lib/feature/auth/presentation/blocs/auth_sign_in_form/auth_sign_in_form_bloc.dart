import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:meta/meta.dart';

part 'auth_sign_in_form_event.dart';

part 'auth_sign_in_form_state.dart';

class AuthSignInFormBloc
    extends Bloc<AuthSignInFormEvent, AuthSignInFormState> {
  AuthSignInFormBloc() : super(AuthSignInFormInitial()) {
    on<AuthSignInFormEmailChangedEvent>(_emailChanged);
    on<AuthSignInFormPasswordChangedEvent>(_passwordChanged);
  }

  Future<void> _emailChanged(
    AuthSignInFormEmailChangedEvent event,
    Emitter emit,
  ) async {}

  Future<void> _passwordChanged(
    AuthSignInFormPasswordChangedEvent event,
    Emitter emit,
  ) async {}
  
  bool inputValidator(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    
    return false;
  }
  
  @override
  Future<void> close() {
    logger.i("===== CLOSE AuthLoginFormBloc =====");
    return super.close();
  }
}
