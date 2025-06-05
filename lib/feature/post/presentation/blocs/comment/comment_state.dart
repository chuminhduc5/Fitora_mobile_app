part of 'comment_bloc.dart';

@immutable
abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

class CommentInitialState extends CommentState {}

class CreateCommentLoadingState extends CommentState {}

class CreateCommentSuccessState extends CommentState {
  final CommentEntity newComment;

  const CreateCommentSuccessState({required this.newComment});

  @override
  List<Object?> get props => [newComment];
}

class CreateCommentFailureState extends CommentState {
  final String message;

  const CreateCommentFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchCommentLoadingState extends CommentState {}

class FetchCommentSuccessState extends CommentState {
  final List<CommentEntity> data;

  const FetchCommentSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchCommentFailureState extends CommentState {
  final String message;

  const FetchCommentFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateRepliesCommentLoadingState extends CommentState {}

class CreateRepliesCommentSuccessState extends CommentState {
  final CommentEntity newRepliesComment;

  const CreateRepliesCommentSuccessState({required this.newRepliesComment});

  @override
  List<Object?> get props => [newRepliesComment];
}

class CreateRepliesCommentFailureState extends CommentState {
  final String message;

  const CreateRepliesCommentFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchRepliesCommentLoadingState extends CommentState {
  final String parentCommentId;

  const FetchRepliesCommentLoadingState({required this.parentCommentId});

  @override
  List<Object?> get props => [parentCommentId];
}

class FetchRepliesCommentSuccessState extends CommentState {
  final String parentCommentId;
  final List<CommentEntity> data;

  const FetchRepliesCommentSuccessState({
    required this.parentCommentId,
    required this.data,
  });

  @override
  List<Object?> get props => [parentCommentId, data];
}

class FetchRepliesCommentFailureState extends CommentState {
  final String parentCommentId;
  final String message;

  const FetchRepliesCommentFailureState(this.parentCommentId, this.message);

  @override
  List<Object?> get props => [parentCommentId, message];
}

class DeleteCommentLoadingState extends CommentState {}

class DeleteCommentSuccessState extends CommentState {}

class DeleteCommentFailureState extends CommentState {
  final String message;
  const DeleteCommentFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
