part of 'friend_bloc.dart';

@immutable
abstract class FriendEvent extends Equatable{
  const FriendEvent();

  @override
  List<Object?> get props => [];
}

class AddFriendEvent extends FriendEvent {
  final String userId;
  const AddFriendEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AcceptFriendEvent extends FriendEvent {
  final String userId;
  const AcceptFriendEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class DeleteFriendEvent extends FriendEvent {
  final String userId;
  const DeleteFriendEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UnfriendEvent extends FriendEvent {
  final String userId;
  const UnfriendEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class FetchFriendEvent extends FriendEvent {}

class FetchSentFriendRequestEvent extends FriendEvent {}

class FetchReceivedFriendRequestEvent extends FriendEvent {}

class FetchRecommendUserEvent extends FriendEvent {}