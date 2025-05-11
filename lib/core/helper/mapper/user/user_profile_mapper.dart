import 'package:fitora_mobile_app/feature/user/data/models/responses/user_profile_model.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';

class UserProfileMapper {
  static UserProfileEntity toEntity(UserProfileModel profile) {
    return UserProfileEntity(
      email: profile.email,
      username: profile.username,
      followerCount: profile.followerCount,
      followingCount: profile.followingCount,
      relationship: profile.relationship.toEntity(),
      userInfo: profile.userInfo.toEntity(),
    );
  }
}
