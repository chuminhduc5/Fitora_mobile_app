import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/create_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/delete_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/get_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/get_replies_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/comment/create_comment_form_data.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CreateCommentUseCase _createCommentUseCase;
  final GetCommentUseCase _getCommentUseCase;
  final GetRepliesCommentUseCase _getRepliesCommentUseCase;
  final DeleteCommentUseCase _deleteCommentUseCase;
  List<CommentEntity> _comments = [];
  final Map<String, List<CommentEntity>> _repliesComment = {};

  CommentBloc(
    this._createCommentUseCase,
    this._getCommentUseCase,
    this._getRepliesCommentUseCase,
    this._deleteCommentUseCase,
  ) : super(CommentInitialState()) {
    on<CreateCommentEvent>(_create);
    on<DeleteCommentEvent>(_delete);
    on<FetchCommentEvent>(_fetchComment);
    on<CreateRepliesCommentEvent>(_createRepliesComment);
    on<FetchRepliesCommentEvent>(_fetchRepliesComment);
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
      (failure) =>
          emit(CreateCommentFailureState(mapFailureToMessage(failure))),
      (data) {
        logger.i('Danh sách comment trước khi thêm: ${_comments.length}');
        _addCommentToList(data);
        logger.i('Danh sách comment sau khi thêm: ${_comments.length}');
        emit(CreateCommentSuccessState(newComment: data));
        // emit(FetchCommentSuccessState(data: _comments));
        _emitUpdatedCommentList(emit);
      },
    );
  }

  Future _delete(DeleteCommentEvent event, Emitter emit) async {
    emit(DeleteCommentLoadingState());

    final result = await _deleteCommentUseCase.call(event.id);

    result.fold(
      (failure) => emit(DeleteCommentFailureState(mapFailureToMessage(failure))),
      (success) {
        logger.i('Danh sách comment trước khi xóa: ${_comments.length}');
        _removeCommentFromList(event.id);
        logger.i('Danh sách comment trước khi xóa: ${_comments.length}');
        emit(DeleteCommentSuccessState());
        // emit(FetchCommentSuccessState(data: _comments));
        _emitUpdatedCommentList(emit);
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

  Future _createRepliesComment(
      CreateRepliesCommentEvent event, Emitter emit) async {
    emit(CreateCommentLoadingState());

    final result = await _createCommentUseCase.call(CreateCommentParams(
      postId: event.params.postId,
      parentCommentId: event.params.parentCommentId,
      content: event.params.content,
      mediaUrl: event.params.mediaUrl,
    ));

    result.fold(
      (failure) =>
          emit(CreateCommentFailureState(mapFailureToMessage(failure))),
      (data) {
        final parentId = data.parentCommentId;
        _repliesComment[parentId!] = [data, ...?_repliesComment[parentId]];
        emit(CreateCommentSuccessState(newComment: data));
        emit(FetchRepliesCommentSuccessState(
            parentCommentId: parentId, data: _repliesComment[parentId]!));
      },
    );
  }

  Future _fetchRepliesComment(
      FetchRepliesCommentEvent event, Emitter emit) async {
    emit(FetchRepliesCommentLoadingState(parentCommentId: event.parentCommentId));

    final result = await _getRepliesCommentUseCase.call(event.parentCommentId);

    result.fold(
      (failure) {
        logger.e("Fetch replies failed: ${mapFailureToMessage(failure)}");
        emit(FetchRepliesCommentFailureState(event.parentCommentId, mapFailureToMessage(failure)));
      },
      (success) {
        logger.i("Replies fetched: $success");
        _repliesComment[event.parentCommentId] = success;
        emit(FetchRepliesCommentSuccessState(
          parentCommentId: event.parentCommentId,
          data: success,
        ));
      },
    );
  }

  void _addCommentToList(CommentEntity comment) {
    _comments.insert(0, comment);
  }

  void _removeCommentFromList(String commentId) {
    _comments.removeWhere((comment) => comment.id == commentId);
  }

  void _emitUpdatedCommentList(Emitter emit) {
    emit(FetchCommentSuccessState(data: _comments));
  }


  List<CommentEntity> getReplies(String parentId) {
    logger.i("Get Replies: ${_repliesComment[parentId] ?? []}");
    return _repliesComment[parentId] ?? [];
  }

  List<CommentEntity> get comments => _comments;

  Map<String, List<CommentEntity>> get repliesMap => _repliesComment;

  @override
  Future<void> close() {
    logger.i("===== CLOSE CommentBloc =====");
    return super.close();
  }
}
