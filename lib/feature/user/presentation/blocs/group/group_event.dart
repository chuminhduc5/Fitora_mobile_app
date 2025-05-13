part of 'group_bloc.dart';

@immutable
abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện tạo nhóm
class CreateGroupEvent extends GroupEvent {
  final CreateGroupFormData params;

  const CreateGroupEvent(this.params);

  @override
  List<Object?> get props => [params];
}

// Sự kiện chỉnh sửa nhóm
class UpdateGroupEvent extends GroupEvent {}

// Sự kiện lấy thông tin nhóm
class FetchGroupByIdEvent extends GroupEvent {
  final String id;

  const FetchGroupByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

// Sự kiện hiện thị thành viên nhóm
class FetchGroupMemberEvent extends GroupEvent {
  final String groupId;

  const FetchGroupMemberEvent({required this.groupId});

  @override
  List<Object?> get props => [groupId];
}

// Sự kiện mời tham gia nhóm
class InviteNewMembersEvent extends GroupEvent {
  final String groupId;
  final List<String> receiverUserIds;

  const InviteNewMembersEvent({
    required this.groupId,
    required this.receiverUserIds,
  });

  @override
  List<Object?> get props => [groupId, receiverUserIds];
}

// Sự kiện hiên thị lời mời tham gia nhóm
class FetchReceivedGroupInviteEvent extends GroupEvent {}

class AcceptGroupInviteEvent extends GroupEvent {
  final String id;

  const AcceptGroupInviteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

// Sự kiện xóa lời mời tham gia nhóm
class DeleteGroupInviteEvent extends GroupEvent {
  final String id;

  const DeleteGroupInviteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

// Sự kiện hiện thị danh sách nhóm
class FetchManagedGroupEvent extends GroupEvent {}
