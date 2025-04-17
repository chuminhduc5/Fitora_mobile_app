import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_check_sign_in_status_use_case.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_sign_in_use_case.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_sign_out_use_case.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_sign_up_use_case.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/auth_sign_in_form_data.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/auth_sign_up_form_data.dart';
import 'package:meta/meta.dart';
import '../../../../../core/utils/logger.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthSignInUseCase _signInUseCase;
  final AuthSignUpUseCase _signUpUseCase;
  final AuthSignOutUseCase _signOutUseCase;
  final AuthCheckSignInStatusUseCase _checkSignInStatusUseCase;

  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
    this._checkSignInStatusUseCase,
  ) : super(AuthInitialState()) {
    on<AuthSignInEvent>(_signIn);
    on<AuthSignUpEvent>(_signUp);
    on<AuthSignOutEvent>(_signOut);
    on<AuthCheckSignInStatusEvent>(_checkSignInStatus);
  }

  Future<void> _signIn(
    AuthSignInEvent event,
    Emitter emit,
  ) async {
    emit(AuthSignInLoadingState());

    final result = await _signInUseCase.call(
      SignInParams(
        email: event.params.email,
        password: event.params.password,
      ),
    );

    result.fold(
      (failure) {
        logg.i("AuthSignInFailureState: $failure");
        emit(AuthSignInFailureState(mapFailureToMessage(failure)));
      },
      (success) => emit(AuthSignInSuccessState(data: success)),
    );
  }

  Future<void> _signUp(
    AuthSignUpEvent event,
    Emitter emit,
  ) async {
    emit(AuthSignUpLoadingState());

    final result = await _signUpUseCase.call(
      SignUpParams(
        username: event.params.username,
        email: event.params.email,
        password: event.params.password,
        confirmPassword: event.params.confirmPassword,
      ),
    );

    result.fold(
      (failure) => emit(AuthSignUpFailureState(mapFailureToMessage(failure))),
      (success) => emit(AuthSignUpSuccessState(data: success)),
    );
  }

  Future<void> _signOut(
    AuthSignOutEvent event,
    Emitter emit,
  ) async {
    emit(AuthSignOutLoadingState());

    final result = await _signOutUseCase.call(NoParams());

    result.fold(
      (failure) => emit(AuthSignOutFailureState(mapFailureToMessage(failure))),
      (success) => emit(const AuthSignOutSuccessState("Sign Out Success")),
    );
  }

  Future<void> _checkSignInStatus(
    AuthCheckSignInStatusEvent event,
    Emitter emit,
  ) async {
    emit(AuthCheckSignInStatusLoadingState());

    final result = await _checkSignInStatusUseCase.call(NoParams());

    result.fold(
      (failure) =>
          emit(AuthCheckSignInStatusFailureState(mapFailureToMessage(failure))),
      (success) => emit(AuthCheckSignInStatusSuccessState(data: success)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AuthBloc =====");
    return super.close();
  }
}
