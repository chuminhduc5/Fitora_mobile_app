class FriendRequestModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String senderName;
  final String senderImageUrl;
  final String receiverName;
  final String receiverImageUrl;
  final int status;
  final DateTime? createDate;

  const FriendRequestModel({
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

  factory FriendRequestModel.frmJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      senderName: json['senderName'] ?? '',
      senderImageUrl: json['senderImageUrl'] ?? '',
      receiverName: json['receiverName'] ?? '',
      receiverImageUrl: json['receiverImageUrl'] ?? '',
      status: json['status'] ?? 0,
      createDate: json['createDate'] != null ? DateTime.tryParse(json['createDate']) : null,
    );
  }
}
