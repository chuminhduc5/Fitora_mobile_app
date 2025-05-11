import 'package:fitora_mobile_app/feature/user/data/models/responses/group_member_model.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_member_entity.dart';

class GroupMemberMapper {
  static GroupMemberEntity toEntity(GroupMemberModel model) {
    return GroupMemberEntity(
      id: model.id,
      groupId: model.groupId,
      groupName: model.groupName,
      groupDescription: model.groupDescription,
      groupPictureUrl: model.groupPictureUrl,
      groupBackgroundPictureUrl: model.groupBackgroundPictureUrl,
      userId: model.userId,
      userName: model.userName,
      email: model.email,
      firstName: model.firstName,
      lastName: model.lastName,
      birthDate: model.birthDate,
      gender: model.gender,
      address: model.address,
      phoneNumber: model.phoneNumber,
      profilePictureUrl: model.profilePictureUrl,
      profileBackgroundPictureUrl: model.profileBackgroundPictureUrl,
      bio: model.bio,
      role: model.role,
      joinedAt: model.joinedAt,
    );
  }
}
