import 'package:fitora_mobile_app/feature/friends/data/models/friend_request_model.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_request_entity.dart';

class FriendRequestMapper {
  static FriendRequestEntity toEntity(FriendRequestModel request) {
    return FriendRequestEntity(
      id: request.id,
      senderId: request.senderId,
      receiverId: request.receiverId,
      senderName: request.senderName,
      senderImageUrl: request.senderImageUrl,
      receiverName: request.receiverName,
      receiverImageUrl: request.receiverImageUrl,
      status: request.status,
      createDate: request.createDate,
    );
  }
}
