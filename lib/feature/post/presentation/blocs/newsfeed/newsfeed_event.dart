part of 'newsfeed_bloc.dart';

@immutable
abstract class NewsfeedEvent extends Equatable {
  const NewsfeedEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewsfeedEvent extends NewsfeedEvent {}

class FetchExploreFeedEvent extends NewsfeedEvent {}

class FetchTrendingFeedEvent extends NewsfeedEvent {}
