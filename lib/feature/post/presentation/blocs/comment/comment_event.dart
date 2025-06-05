part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

class CreateCommentEvent extends CommentEvent {
  final CreateCommentFormData params;

  const CreateCommentEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class FetchCommentEvent extends CommentEvent {
  final String postId;

  const FetchCommentEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class CreateRepliesCommentEvent extends CommentEvent {
  final CreateCommentFormData params;

  const CreateRepliesCommentEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class FetchRepliesCommentEvent extends CommentEvent {
  final String parentCommentId;

  const FetchRepliesCommentEvent({required this.parentCommentId});

  @override
  List<Object?> get props => [parentCommentId];
}

class DeleteCommentEvent extends CommentEvent {
  final String id;
  final String postId;
  const DeleteCommentEvent({required this.id, required this.postId});

  @override
  List<Object?> get props => [id, postId];
}