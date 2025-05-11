import '../../../../feature/user/data/models/responses/user_model.dart';
import '../../../../feature/user/domain/entities/user_entity.dart';

class UserMapper {
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
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
