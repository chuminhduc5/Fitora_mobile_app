import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_member_entity.dart';

class GroupResponseEntity extends Equatable {
  final GroupEntity group;
  final GroupMemberEntity groupMember;

  const GroupResponseEntity({
    required this.group,
    required this.groupMember,
  });

  @override
  List<Object?> get props => [group, groupMember];
}

class GroupEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int privacy;
  final bool requirePostApproval;
  final String coverImageUrl;
  final String avatarUrl;
  final int status;
  final int memberCount;

  const GroupEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.privacy,
    required this.requirePostApproval,
    required this.coverImageUrl,
    required this.avatarUrl,
    required this.status,
    required this.memberCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        privacy,
        requirePostApproval,
        coverImageUrl,
        avatarUrl,
        status,
        memberCount,
      ];
}
