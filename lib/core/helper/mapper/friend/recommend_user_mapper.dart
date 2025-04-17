import 'package:fitora_mobile_app/feature/friends/data/models/recommend_user_model.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/recommend_user_entity.dart';

class RecommendUserMapper {
  static RecommendUserEntity toEntity(RecommendUserModel model) {
    return RecommendUserEntity(
      id: model.id,
      isFriend: model.isFriend,
      isFollowing: model.isFollowing,
      email: model.email,
      username: model.username,
      firstName: model.firstName,
      lastName: model.lastName,
      birthDate: model.birthDate,
      gender: model.gender,
      address: model.address,
      phoneNumber: model.phoneNumber,
      profilePictureUrl: model.profilePictureUrl,
      bio: model.bio,
    );
  }
}
