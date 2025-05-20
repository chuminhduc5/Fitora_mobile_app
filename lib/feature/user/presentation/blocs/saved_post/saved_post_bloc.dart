import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/get_saved_post_use_case.dart';
import 'package:meta/meta.dart';

part 'saved_post_event.dart';

part 'saved_post_state.dart';

class SavedPostBloc extends Bloc<SavedPostEvent, SavedPostState> {
  final GetSavedPostUseCase _getSavedPostUseCase;

  SavedPostBloc(this._getSavedPostUseCase) : super(SavedPostInitialState()) {
    on<FetchSavedPostEvent>(_fetchSavedPost);
  }

  Future _fetchSavedPost(FetchSavedPostEvent event, Emitter emit) async {
    emit(FetchSavedPostLoadingState());

    final result = await _getSavedPostUseCase.call(NoParams());

    result.fold(
      (failure) => emit(FetchSavedPostFailureState(mapFailureToMessage(failure))),
      (success) => emit(FetchSavedPostSuccessState(data: success)),
    );
  }
}