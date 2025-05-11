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
