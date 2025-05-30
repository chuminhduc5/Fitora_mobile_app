import 'package:fitora_mobile_app/feature/user/data/models/responses/friend_model.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/friend_entity.dart';

class FriendMapper {
  static FriendEntity toEntity(FriendModel friend) {
    return FriendEntity(
      id: friend.id,
      username: friend.username,
      email: friend.email,
      firstName: friend.firstName,
      birthDate: friend.birthDate,
      gender: friend.gender,
      address: friend.address,
      phoneNumber: friend.phoneNumber,
      profilePictureUrl: friend.profilePictureUrl,
      bio: friend.bio,
    );
  }
}