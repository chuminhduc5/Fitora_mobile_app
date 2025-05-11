part of 'friend_bloc.dart';

@immutable
abstract class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện thêm bạn bè
class AddFriendEvent extends FriendEvent {
  final String userId;
  const AddFriendEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

// Sự kiện chấp nhận kết bạn
class AcceptFriendEvent extends FriendEvent {
  final String userId;
  const AcceptFriendEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

// Sự kiện xóa bạn bè
class DeleteFriendEvent extends FriendEvent {
  final String userId;
  const DeleteFriendEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

// Sự kiện
class UnfriendEvent extends FriendEvent {
  final String userId;
  const UnfriendEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

// Sự kiện lấy danh sách bạn bè
class FetchFriendEvent extends FriendEvent {}

// Sự kiện lấy danh sách lượt gửi kết bạn
class FetchSentFriendRequestEvent extends FriendEvent {}

// Sự kiện lấy danh sách lời mời kết bạn
class FetchReceivedFriendRequestEvent extends FriendEvent {}

// Sự kiện lấy danh sách gợi ý kết bạn
class FetchRecommendUserEvent extends FriendEvent {}