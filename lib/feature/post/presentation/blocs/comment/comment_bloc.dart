import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_response_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/create_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/get_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/comment/create_comment_form_data.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CreateCommentUseCase _createCommentUseCase;
  final GetCommentUseCase _getCommentUseCase;
  List<CommentEntity> _comments = [];

  CommentBloc(
    this._createCommentUseCase,
    this._getCommentUseCase,
  ) : super(CommentInitialState()) {
    on<CreateCommentEvent>(_create);
    on<FetchCommentEvent>(_fetchComment);
  }

  Future _create(CreateCommentEvent event, Emitter emit) async {
    emit(CreateCommentLoadingState());

    final result = await _createCommentUseCase.call(CreateCommentParams(
      postId: event.params.postId,
      parentCommentId: event.params.parentCommentId,
      content: event.params.content,
      mediaUrl: event.params.mediaUrl,
    ));

    result.fold(
      (failure) => emit(CreateCommentFailureState(mapFailureToMessage(failure))),
      (data) {
        _addCommentToList(data);
        emit(CreateCommentSuccessState(newComment: data));
        emit(FetchCommentSuccessState(data: _comments));
      },
    );
  }

  Future _fetchComment(FetchCommentEvent event, Emitter emit) async {
    emit(FetchCommentLoadingState());

    final result = await _getCommentUseCase.call(event.postId);

    result.fold(
      (failure) => emit(FetchCommentFailureState(mapFailureToMessage(failure))),
      (success) {
        _comments = success;
        emit(FetchCommentSuccessState(data: _comments));
      },
    );
  }

  void _addCommentToList(CommentEntity comment) {
    _comments.insert(0, comment);
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE CommentBloc =====");
    return super.close();
  }
}
