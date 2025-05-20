import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/interact/vote_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/interact/interact_post_from_data.dart';
import 'package:meta/meta.dart';

part 'interact_event.dart';

part 'interact_state.dart';

class InteractBloc extends Bloc<InteractEvent, InteractState> {
  final VotePostUseCase _votePostUseCase;

  InteractBloc(this._votePostUseCase) : super(InteractPostInitialState()) {
    on<InteractPostEvent>(_interact);
  }

  Future _interact(InteractPostEvent event, Emitter emit) async {
    emit(InteractPostLoadingState());

    final result = await _votePostUseCase.call(VotePostParams(
      userId: event.userId,
      postId: event.postId,
      voteType: event.voteType,
    ));

    result.fold(
      (failure) => emit(InteractPostFailureState(mapFailureToMessage(failure))),
      (success) => emit(InteractPostSuccessState()),
    );
  }
}
