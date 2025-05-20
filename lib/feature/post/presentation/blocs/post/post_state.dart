part of 'post_bloc.dart';

@immutable
abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitialState extends PostState {}

// State Create Post
class CreatePostLoadingState extends PostState {}

class CreatePostSuccessState extends PostState {}

class CreatePostFailureState extends PostState {
  final String message;

  const CreatePostFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// State Update Post

// State Delete Post

// State Save Post
class SavePostLoadingState extends PostState {}

class SavePostSuccessState extends PostState {}

class SavePostFailureState extends PostState {
  final String message;

  const SavePostFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
