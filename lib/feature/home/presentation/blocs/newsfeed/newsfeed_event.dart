part of 'newsfeed_bloc.dart';

@immutable
abstract class NewsfeedEvent extends Equatable {
  const NewsfeedEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewsfeedEvent extends NewsfeedEvent {
  final NewsfeedReqParams params;

  const FetchNewsfeedEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
