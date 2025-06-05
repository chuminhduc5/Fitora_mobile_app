import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/create_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/delete_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/save_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/update_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/post/create_post_form_data.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/post/update_post_form_data.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase _createPostUseCase;
  final UpdatePostUseCase _updatePostUseCase;
  final DeletePostUseCase _deletePostUseCase;
  final SavePostUseCase _savePostUseCasel;

  PostBloc(
    this._createPostUseCase,
    this._updatePostUseCase,
    this._deletePostUseCase,
    this._savePostUseCasel,
  ) : super(PostInitialState()) {
    on<CreatePostEvent>(_create);
    on<UpdatePostEvent>(_update);
    on<DeletePostEvent>(_delete);
    on<SavePostEvent>(_save);
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

  Future<void> _update(UpdatePostEvent event, Emitter emit) async {
    emit(UpdatePostLoadingState());

    final result = await _updatePostUseCase.call(UpdatePostParams(
      id: event.id,
      content: event.params.content,
      mediaUrl: event.params.mediaUrl,
      privacy: event.params.privacy,
      isApproved: event.params.isApproved,
    ));

    result.fold(
      (failure) => emit(UpdatePostFailureState(mapFailureToMessage(failure))),
      (success) => emit(UpdatePostSuccessState()),
    );
  }

  Future<void> _delete(DeletePostEvent event, Emitter emit) async {
    emit(DeletePostLoadingState());

    final result = await _deletePostUseCase.call(event.postId);

    result.fold(
      (failure) => emit(DeletePostFailureState(mapFailureToMessage(failure))),
      (success) => emit(DeletePostSuccessState()),
    );
  }

  Future<void> _save(SavePostEvent event, Emitter emit) async {
    emit(SavePostLoadingState());

    final result = await _savePostUseCasel.call(SavePostParams(
      userId: event.userId,
      postId: event.postId,
    ));

    result.fold(
      (failure) => emit(SavePostFailureState(mapFailureToMessage(failure))),
      (success) => emit(SavePostSuccessState()),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE PostBloc =====");
    return super.close();
  }
}
