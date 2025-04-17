import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/create_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/create_post_form_data.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase _createPostUseCase;

  PostBloc(this._createPostUseCase) : super(PostInitialState()) {
    on<CreatePostEvent>(_create);
  }

  Future<void> _create(CreatePostEvent event, Emitter emit) async {
    emit(CreatePostLoadingState());

    final result = await _createPostUseCase.call(CreatePostParams(
      content: event.params.content,
      mediaUrl: event.params.mediaUrl,
      privacy: event.params.privacy,
      groupId: event.params.groupId,
      categoryId: event.params.categoryId,
    ));

    result.fold(
      (failure) => emit(CreatePostFailureState(mapFailureToMessage(failure))),
      (success) => emit(CreatePostSuccessState()),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE PostBloc =====");
    return super.close();
  }
}
