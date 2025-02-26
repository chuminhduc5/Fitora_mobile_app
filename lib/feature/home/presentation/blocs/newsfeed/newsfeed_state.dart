part of 'newsfeed_bloc.dart';

@immutable
abstract class NewsfeedState extends Equatable{
  const NewsfeedState();

  @override
  List<Object?> get props => [];
}

class NewsfeedInitialState extends NewsfeedState {}

class FetchNewsfeedLoadingState extends NewsfeedState {}

class FetchNewsfeedSuccessState extends NewsfeedState {
  final List<NewsfeedEntity> data;
  const FetchNewsfeedSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchNewsfeedFailureState extends NewsfeedState {
  final String message;
  const FetchNewsfeedFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}