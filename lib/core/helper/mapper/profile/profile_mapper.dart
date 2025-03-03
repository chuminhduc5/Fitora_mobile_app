import 'package:fitora_mobile_app/feature/profile/data/models/responses/profile_model.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';

class ProfileMapper {
  static ProfileEntity toEntity(ProfileModel profile) {
    return ProfileEntity(
      email: profile.email,
      username: profile.username,
      followerCount: profile.followerCount,
      followingCount: profile.followingCount,
      relationship: RelationshipMapper.toEntity(profile.relationship),
      userInfo: UserInfoMapper.toEntity(profile.userInfo),
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
