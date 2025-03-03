import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/get_newsfeed_use_case.dart';
import 'package:meta/meta.dart';

part 'newsfeed_event.dart';

part 'newsfeed_state.dart';

class NewsfeedBloc extends Bloc<NewsfeedEvent, NewsfeedState> {
  final GetNewsfeedUseCase _getNewsfeedUseCase;

  NewsfeedBloc(this._getNewsfeedUseCase) : super(NewsfeedInitialState()) {
    on<FetchNewsfeedEvent>(_onFetchNewsfeed);
  }

  Future<void> _onFetchNewsfeed(FetchNewsfeedEvent event, Emitter emit) async {
    emit(FetchNewsfeedLoadingState());
    final result = await _getNewsfeedUseCase.call(NoParams());
    result.fold(
      (error) => emit(FetchNewsfeedFailureState(message: mapFailureToMessage(error))),
      (data) => emit(FetchNewsfeedSuccessState(data: data)),
    );
  }
}
