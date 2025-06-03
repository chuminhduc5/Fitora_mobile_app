part of 'group_bloc.dart';

@immutable
abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

class GroupInitialState extends GroupState {}

// Trạng thái sự kiện tạo nhóm
class CreateGroupLoadingState extends GroupState {}

class CreateGroupSuccessState extends GroupState {
  final GroupMemberEntity data;

  const CreateGroupSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class CreateGroupFailureState extends GroupState {
  final String message;

  const CreateGroupFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện chỉnh sửa nhóm
class UpdateGroupLoadingState extends GroupState {}

class UpdateGroupSuccessState extends GroupState {}

class UpdateGroupFailureState extends GroupState {
  final String message;

  const UpdateGroupFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện xóa nhóm
class DeleteGroupLoadingState extends GroupState {}

class DeleteGroupSuccessState extends GroupState {}

class DeleteGroupFailureState extends GroupState {
  final String message;

  const DeleteGroupFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện lấy thông nhóm
class FetchGroupByIdLoadingState extends GroupState {}

class FetchGroupByIdSuccessState extends GroupState {
  final GroupResponseEntity data;

  const FetchGroupByIdSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchGroupByIdFailureState extends GroupState {
  final String message;

  const FetchGroupByIdFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện lấy thông tin thành viên nhóm
class FetchGroupMemberLoadingState extends GroupState {}

class FetchGroupMemberSuccessState extends GroupState {
  final List<GroupMemberEntity> data;

  const FetchGroupMemberSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchGroupMemberFailureState extends GroupState {
  final String message;

  const FetchGroupMemberFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện mời thành viên tham gia nhóm
class InviteNewMembersLoadingState extends GroupState {}

class InviteNewMembersSuccessState extends GroupState {}

class InviteNewMembersFailureState extends GroupState {
  final String message;

  const InviteNewMembersFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện lấy danh sách lời mời tham gia nhóm
class FetchReceivedGroupInviteLoadingState extends GroupState {}

class FetchReceivedGroupInviteSuccessState extends GroupState {
  final List<ReceivedGroupInviteEntity> data;

  const FetchReceivedGroupInviteSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchReceivedGroupInviteFailureState extends GroupState {
  final String message;

  const FetchReceivedGroupInviteFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện chấp nhận tham lời mới nhóm
class AcceptGroupInviteLoadingState extends GroupState {}

class AcceptGroupInviteSuccessState extends GroupState {}

class AcceptGroupInviteFailureState extends GroupState {
  final String message;

  const AcceptGroupInviteFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái sự kiện xóa tham lời mới nhóm
class DeleteGroupInviteLoadingState extends GroupState {}

class DeleteGroupInviteSuccessState extends GroupState {}

class DeleteGroupInviteFailureState extends GroupState {
  final String message;

  const DeleteGroupInviteFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchManagedGroupLoadingState extends GroupState {}

class FetchManagedGroupSuccessState extends GroupState {
  final List<ManagedGroupEntity> data;

  const FetchManagedGroupSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchManagedGroupFailureState extends GroupState {
  final String message;

  const FetchManagedGroupFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchJoinedGroupLoadingState extends GroupState {}

class FetchJoinedGroupSuccessState extends GroupState {
  final List<ManagedGroupEntity> data;

  const FetchJoinedGroupSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchJoinedGroupFailureState extends GroupState {
  final String message;

  const FetchJoinedGroupFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
