part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện nhận lời mời kết bạn
class FetchReceivedFriendRequestEvent extends NotificationEvent {}

// Sự kiện nhận lời mời tham gia nhóm
class FetchReceivedGroupInviteEvent extends NotificationEvent {}
