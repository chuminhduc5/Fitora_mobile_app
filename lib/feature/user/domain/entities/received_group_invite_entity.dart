import 'package:equatable/equatable.dart';

class ReceivedGroupInviteEntity extends Equatable {
  final String id;
  final String groupId;
  final String groupName;
  final String groupImageUrl;
  final String senderUserId;
  final String senderName;
  final String senderImageUrl;
  final String receiverUserId;
  final String receiverName;
  final String receiverImageUrl;
  final int status;

  const ReceivedGroupInviteEntity({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.groupImageUrl,
    required this.senderUserId,
    required this.senderName,
    required this.senderImageUrl,
    required this.receiverUserId,
    required this.receiverName,
    required this.receiverImageUrl,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        groupId,
        groupName,
        groupImageUrl,
        senderUserId,
        senderName,
        senderImageUrl,
        receiverUserId,
        receiverName,
        receiverImageUrl,
        status,
      ];
}
