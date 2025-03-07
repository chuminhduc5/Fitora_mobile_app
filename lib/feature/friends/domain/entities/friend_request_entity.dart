import 'package:equatable/equatable.dart';

class FriendRequestEntity extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String senderName;
  final String senderImageUrl;
  final String receiverName;
  final String receiverImageUrl;
  final int status;
  final DateTime createDate;

  const FriendRequestEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.senderImageUrl,
    required this.receiverName,
    required this.receiverImageUrl,
    required this.status,
    required this.createDate,
  });

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        senderName,
        senderImageUrl,
        receiverId,
        receiverImageUrl,
        status,
        createDate,
      ];
}
