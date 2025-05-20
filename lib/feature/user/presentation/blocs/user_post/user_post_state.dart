part of 'user_post_bloc.dart';

@immutable
abstract class UserPostState extends Equatable {
  const UserPostState();

  @override
  List<Object?> get props => [];
}

class FetchUserPostInitialState extends UserPostState {}

class FetchUserPostLoadingState extends UserPostState {}

class FetchUserPostSuccessState extends UserPostState {
  final List<PostEntity> data;
  const FetchUserPostSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchUserPostFailureState extends UserPostState {
  final String message;
  const FetchUserPostFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
