part of 'post_form_bloc.dart';

@immutable
abstract class PostFormEvent extends Equatable {
  const PostFormEvent();

  @override
  List<Object?> get props => [];
}

class PostLoadDataEvent extends PostFormEvent {
  final PostFormData params;

  const PostLoadDataEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class PostContentChangedEvent extends PostFormEvent {
  final String content;

  const PostContentChangedEvent(this.content);

  @override
  List<Object?> get props => [content];
}

class PostMediaUrlChangedEvent extends PostFormEvent {
  final String mediaUrl;

  const PostMediaUrlChangedEvent(this.mediaUrl);

  @override
  List<Object?> get props => [mediaUrl];
}

class PostPrivacyChangedEvent extends PostFormEvent {
  final int privacy;

  const PostPrivacyChangedEvent(this.privacy);

  @override
  List<Object?> get props => [privacy];
}

class PostGroupIdChangedEvent extends PostFormEvent {
  final String groupId;

  const PostGroupIdChangedEvent(this.groupId);

  @override
  List<Object?> get props => [groupId];
}
