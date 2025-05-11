import 'package:fitora_mobile_app/feature/user/data/models/responses/group_member_model.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';

class GroupResponseModel {
  final GroupModel group;
  final GroupMemberModel groupMember;

  const GroupResponseModel({
    required this.group,
    required this.groupMember,
  });

  factory GroupResponseModel.fromJson(Map<String, dynamic> json) {
    return GroupResponseModel(
      group: GroupModel.fromJson(json['group']),
      groupMember: GroupMemberModel.fromJson(json['groupMember']),
    );
  }
}

class GroupModel {
  final String id;
  final String name;
  final String description;
  final int privacy;
  final bool requirePostApproval;
  final String coverImageUrl;
  final String avatarUrl;
  final int status;
  final int memberCount;

  const GroupModel({
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

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      privacy: json['privacy'],
      requirePostApproval: json['requirePostApproval'],
      coverImageUrl: json['coverImageUrl'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      status: json['status'],
      memberCount: json['memberCount'],
    );
  }

  GroupEntity toEntity() {
    return GroupEntity(
      id: id,
      name: name,
      description: description,
      privacy: privacy,
      requirePostApproval: requirePostApproval,
      coverImageUrl: coverImageUrl,
      avatarUrl: avatarUrl,
      status: status,
      memberCount: memberCount,
    );
  }
}
