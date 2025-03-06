class PostModel {
  final String id;
  final String userId;
  final String groupId;
  final String content;
  final String mediaUrl;
  final int votesCount;
  final int commentsCount;
  final int score;
  final int privacy;
  final DateTime? createAt;
  final DateTime? updateAt;
  final bool isDeleted;

  const PostModel({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.content,
    required this.mediaUrl,
    required this.votesCount,
    required this.commentsCount,
    required this.score,
    required this.privacy,
    required this.createAt,
    required this.updateAt,
    required this.isDeleted,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      groupId: json['groupId'] ?? '',
      content: json['content'] ?? '',
      mediaUrl: json['mediaUrl'] ?? '',
      votesCount: json['votesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      score: json['score'] ?? 0,
      privacy: json['privacy'] ?? 0,
      createAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updateAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      isDeleted: json['isDeleted'] ?? false,
    );
  }
}
