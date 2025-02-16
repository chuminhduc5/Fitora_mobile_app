import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_sign_up_form_event.dart';
part 'auth_sign_up_form_state.dart';

class AuthSignUpFormBloc extends Bloc<AuthSignUpFormEvent, AuthSignUpFormState> {
  AuthSignUpFormBloc() : super(AuthSignUpFormInitial()) {
    on<AuthSignUpFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
