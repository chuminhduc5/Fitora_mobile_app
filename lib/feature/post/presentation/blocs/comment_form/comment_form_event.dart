part of 'comment_form_bloc.dart';

@immutable
abstract class CommentFormEvent extends Equatable {
  const CommentFormEvent();

  @override
  List<Object?> get props => [];
}

class CommentLoadDataEvent extends CommentFormEvent {
  final CommentFormData params;

  const CommentLoadDataEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class CommentContentChangedEvent extends  CommentFormEvent {
  final String content;

  const CommentContentChangedEvent(this.content);

  @override
  List<Object?> get props => [content];
}

class CommentMediaUrlChangedEvent extends CommentFormEvent {
  final String mediaUrl;

  const CommentMediaUrlChangedEvent(this.mediaUrl);

  @override
  List<Object?> get props => [mediaUrl];
}
