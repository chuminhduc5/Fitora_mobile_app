import 'package:fitora_mobile_app/feature/profile/data/models/responses/profile_model.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';

class ProfileMapper {
  static ProfileEntity toEntity(ProfileModel profile) {
    return ProfileEntity(
      email: profile.email,
      username: profile.username,
      followerCount: profile.followerCount,
      followingCount: profile.followingCount,
      relationship: profile.relationship.toEntity(),
      userInfo: profile.userInfo.toEntity(),
    );
  }
}
