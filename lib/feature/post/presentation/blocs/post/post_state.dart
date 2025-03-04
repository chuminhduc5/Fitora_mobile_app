part of 'post_bloc.dart';

@immutable
abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitialState extends PostState {}

class CreatePostLoadingState extends PostState {}

class CreatePostSuccessState extends PostState {}

class CreatePostFailureState extends PostState {
  final String message;

  const CreatePostFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
