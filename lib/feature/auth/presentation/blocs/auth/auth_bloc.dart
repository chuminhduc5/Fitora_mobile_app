import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_in_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_up_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSignInEvent>(_signIn);
    on<AuthSignUpEvent>(_signUp);
    on<AuthSignOutEvent>(_signOut);
    on<AuthCheckSignInStatusEvent>(_checkSignInStatus);
  }

  Future<void> _signIn(AuthSignInEvent event, Emitter emit) async {}

  Future<void> _signUp(AuthSignUpEvent event, Emitter emit) async {}

  Future<void> _signOut(AuthSignOutEvent event, Emitter emit) async {}

  Future<void> _checkSignInStatus(AuthCheckSignInStatusEvent event, Emitter emit) async {}
}
