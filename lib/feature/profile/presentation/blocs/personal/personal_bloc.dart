import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/personal_entity.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/get_personal_use_case.dart';
import 'package:meta/meta.dart';

part 'personal_event.dart';

part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  final GetPersonalUseCase _getPersonalUseCase;

  PersonalBloc(this._getPersonalUseCase) : super(FetchPersonalInitialState()) {
    on<FetchPersonalEvent>(_onFetchPersonal);
  }

  Future<void> _onFetchPersonal(FetchPersonalEvent event, Emitter emit) async {
    emit(FetchPersonalLoadingState());
    final result = await _getPersonalUseCase.call(NoParams());
    result.fold(
      (error) => emit(FetchPersonalFailureState(message: mapFailureToMessage(error))),
      (data) => emit(FetchPersonalSuccessState(data: data)),
    );
  }
}
