class ReceivedGroupInviteModel {
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

  const ReceivedGroupInviteModel({
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

  factory ReceivedGroupInviteModel.fromJson(Map<String, dynamic> json) {
    return ReceivedGroupInviteModel(
      id: json['id'],
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupImageUrl: json['groupImageUrl'],
      senderUserId: json['senderUserId'],
      senderName: json['senderName'],
      senderImageUrl: json['senderImageUrl'],
      receiverUserId: json['receiverUserId'],
      receiverName: json['receiverName'],
      receiverImageUrl: json['receiverImageUrl'],
      status: json['status'],
    );
  }
}
