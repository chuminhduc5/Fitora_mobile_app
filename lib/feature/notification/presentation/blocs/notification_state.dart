part of 'notification_bloc.dart';

@immutable
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitialState extends NotificationState {}

// Trạng thái nhận lời mời kết bạn
class FetchReceivedFriendRequestLoadingState extends NotificationState {}

class FetchReceivedFriendRequestSuccessState extends NotificationState {
  final List<FriendRequestEntity> data;
  const FetchReceivedFriendRequestSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchReceivedFriendRequestFailureState extends NotificationState {
  final String message;
  const FetchReceivedFriendRequestFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái nhận lời mời tham gia nhóm
class FetchReceivedGroupInviteLoadingState extends NotificationState {}

class FetchReceivedGroupInviteSuccessState extends NotificationState {
  final List<ReceivedGroupInviteEntity> data;

  const FetchReceivedGroupInviteSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchReceivedGroupInviteFailureState extends NotificationState {
  final String message;

  const FetchReceivedGroupInviteFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
