import 'package:fitora_mobile_app/feature/profile/data/models/responses/personal_model.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/personal_entity.dart';

class PersonalMapper {
  static PersonalEntity toEntity(PersonalModel personal) {
    return PersonalEntity(
      email: personal.email,
      username: personal.username,
      followerCount: personal.followerCount,
      followingCount: personal.followingCount,
      relationship: RelationshipMapper.toEntity(personal.relationship),
      userInfo: UserInfoMapper.toEntity(personal.userInfo),
    );
  }
}

class RelationshipMapper {
  static RelationshipEntity toEntity(RelationshipModel relationship) {
    return RelationshipEntity(
      isFriend: relationship.isFriend,
      isFriendRequest: relationship.isFriendRequest,
      isFollowing: relationship.isFollowing,
    );
  }
}

class UserInfoMapper {
  static UserInfoEntity toEntity(UserInfoModel userInfo) {
    return UserInfoEntity(
      userId: userInfo.userId,
      firstName: userInfo.firstName,
      lastName: userInfo.lastName,
      birthDate: userInfo.birthDate,
      gender: userInfo.gender,
      address: userInfo.address,
      phoneNumber: userInfo.phoneNumber,
      profilePictureUrl: userInfo.profilePictureUrl,
      profileBackgroundPictureUrl: userInfo.profileBackgroundPictureUrl,
      bio: userInfo.bio,
      id: userInfo.id,
      createdAt: userInfo.createdAt,
      createdBy: userInfo.createdBy,
      lastModified: userInfo.lastModified,
      lastModifiedBy: userInfo.lastModifiedBy,
    );
  }
}
