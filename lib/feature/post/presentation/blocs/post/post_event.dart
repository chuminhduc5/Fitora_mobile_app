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
