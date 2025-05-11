part of 'friend_bloc.dart';

@immutable
abstract class FriendState extends Equatable {
  const FriendState();

  @override
  List<Object?> get props => [];
}

class FriendInitialState extends FriendState {}

// Trạng thái sự kiện AddFriendEvent
class AddFriendLoadingState extends FriendState {}

class AddFriendSuccessState extends FriendState {}

class AddFriendFailureState extends FriendState {
  final String message;
  const AddFriendFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện AcceptFriendEvent
class AcceptFriendLoadingState extends FriendState {}

class AcceptFriendSuccessState extends FriendState {}

class AcceptFriendFailureState extends FriendState {
  final String message;
  const AcceptFriendFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện DeleteFriendEvent
class DeleteFriendLoadingState extends FriendState {}

class DeleteFriendSuccessState extends FriendState {}

class DeleteFriendFailureState extends FriendState {
  final String message;
  const DeleteFriendFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện UnfriendEvent
class UnfriendLoadingState extends FriendState {}

class UnfriendSuccessState extends FriendState {}

class UnfriendFailureState extends FriendState {
  final String message;
  const UnfriendFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện FetchFriendEvent
class FetchFriendLoadingState extends FriendState {}

class FetchFriendSuccessState extends FriendState {
  final List<FriendEntity> data;
  const FetchFriendSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchFriendFailureState extends FriendState {
  final String message;
  const FetchFriendFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện FetchSentFriendRequestEvent
class FetchSentFriendRequestLoadingState extends FriendState {}

class FetchSentFriendRequestSuccessState extends FriendState {
  final List<FriendRequestEntity> data;
  const FetchSentFriendRequestSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchSentFriendRequestFailureState extends FriendState {
  final String message;
  const FetchSentFriendRequestFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện
class FetchReceivedFriendRequestLoadingState extends FriendState {}

class FetchReceivedFriendRequestSuccessState extends FriendState {
  final List<FriendRequestEntity> data;
  const FetchReceivedFriendRequestSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchReceivedFriendRequestFailureState extends FriendState {
  final String message;
  const FetchReceivedFriendRequestFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// class FetchRecommendUserLoadingState extends FriendState {}
//
// class FetchRecommendUserSuccessState extends FriendState {
//   final List<RecommendUserEntity> users;
//
//   const FetchRecommendUserSuccessState({required this.users});
//
//   @override
//   List<Object?> get props => [users];
// }
//
// class FetchRecommendUserFailureState extends FriendState {
//   final String message;
//
//   const FetchRecommendUserFailureState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }