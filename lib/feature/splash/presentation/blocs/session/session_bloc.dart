import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_check_sign_in_status_use_case.dart';
import 'package:meta/meta.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthCheckSignInStatusUseCase _checkSignInStatusUseCase;
  SessionBloc(this._checkSignInStatusUseCase) : super(SessionInitialState()) {
    on<CheckSignInStatusEvent>(_checkSignInStatus);
  }

  Future<void> _checkSignInStatus(
      CheckSignInStatusEvent event,
      Emitter emit,
      ) async {
    emit(CheckSignInStatusLoadingState());

    final result = await _checkSignInStatusUseCase.call(NoParams());

    result.fold(
          (failure) => emit(CheckSignInStatusFailureState(mapFailureToMessage(failure))),
          (success) => emit(CheckSignInStatusSuccessState(data: success)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE SessionBloc =====");
    return super.close();
  }
}
