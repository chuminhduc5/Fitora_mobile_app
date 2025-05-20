part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class CreatePostEvent extends PostEvent {
  final CreatePostFormData params;

  const CreatePostEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UpdatePostEvent extends PostEvent {}

class DeletePostEvent extends PostEvent {
  final String postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class SavePostEvent extends PostEvent {
  final String userId;
  final String postId;

  const SavePostEvent({
    required this.userId,
    required this.postId,
  });

  @override
  List<Object?> get props => [userId, postId];
}
