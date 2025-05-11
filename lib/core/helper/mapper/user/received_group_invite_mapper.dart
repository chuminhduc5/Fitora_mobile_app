import 'package:fitora_mobile_app/feature/user/data/models/responses/received_group_invite_model.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/received_group_invite_entity.dart';

class ReceivedGroupInviteMapper {
  static ReceivedGroupInviteEntity toEntity(ReceivedGroupInviteModel model) {
    return ReceivedGroupInviteEntity(
      id: model.id,
      groupId: model.groupId,
      groupName: model.groupName,
      groupImageUrl: model.groupImageUrl,
      senderUserId: model.senderUserId,
      senderName: model.senderName,
      senderImageUrl: model.senderImageUrl,
      receiverUserId: model.receiverUserId,
      receiverName: model.receiverName,
      receiverImageUrl: model.receiverImageUrl,
      status: model.status,
    );
  }
}
