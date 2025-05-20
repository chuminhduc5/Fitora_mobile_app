part of 'saved_post_bloc.dart';

@immutable
abstract class SavedPostState extends Equatable {
  const SavedPostState();

  @override
  List<Object?> get props => [];
}

class SavedPostInitialState extends SavedPostState {}

class FetchSavedPostLoadingState extends SavedPostState {}

class FetchSavedPostSuccessState extends SavedPostState {
  final List<PostEntity> data;

  const FetchSavedPostSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchSavedPostFailureState extends SavedPostState {
  final String message;

  const FetchSavedPostFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
