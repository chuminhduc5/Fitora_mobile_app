part of 'notification_bloc.dart';

@immutable
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitialState extends NotificationState {}

class FetchNotificationLoadingState extends NotificationState {}

class FetchNotificationSuccessState extends NotificationState {
  final List<FriendRequestEntity> friendRequests;
  final List<ReceivedGroupInviteEntity> groupInvites;

  const FetchNotificationSuccessState({
    required this.friendRequests,
    required this.groupInvites,
  });

  @override
  List<Object?> get props => [friendRequests, groupInvites];
}

class FetchNotificationFailureState extends NotificationState {
  final String message;

  const FetchNotificationFailureState(this.message);

  @override
  List<Object?> get props => [message];
}