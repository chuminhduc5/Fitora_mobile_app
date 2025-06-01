part of 'newsfeed_bloc.dart';

@immutable
abstract class NewsfeedState extends Equatable {
  const NewsfeedState();

  @override
  List<Object?> get props => [];
}

class NewsfeedInitialState extends NewsfeedState {}

class FetchNewsfeedLoadingState extends NewsfeedState {}

class FetchNewsfeedSuccessState extends NewsfeedState {
  final List<PostEntity> data;

  const FetchNewsfeedSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchNewsfeedFailureState extends NewsfeedState {
  final String message;

  const FetchNewsfeedFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchExploreFeedLoadingState extends NewsfeedState {}

class FetchExploreFeedSuccessState extends NewsfeedState {
  final List<PostEntity> data;

  const FetchExploreFeedSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchExploreFeedFailureState extends NewsfeedState {
  final String message;

  const FetchExploreFeedFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchTrendingFeedLoadingState extends NewsfeedState {}

class FetchTrendingFeedSuccessState extends NewsfeedState {
  final List<PostEntity> data;

  const FetchTrendingFeedSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchTrendingFeedFailureState extends NewsfeedState {
  final String message;

  const FetchTrendingFeedFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

