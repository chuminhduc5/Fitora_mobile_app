class NewsfeedModel {
  final String id;
  final String userId;
  final String groupId;
  final String content;
  final String mediaUrl;
  final int votesCount;
  final int commentsCount;
  final int score;
  final int privacy;
  final DateTime createAt;
  final DateTime updateAt;
  final bool isDeleted;

  const NewsfeedModel({
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

  factory NewsfeedModel.fromJson(Map<String, dynamic> json) {
    return NewsfeedModel(
      id: json['id'],
      userId: json['userId'],
      groupId: json['groupId'],
      content: json['content'],
      mediaUrl: json['mediaUrl'],
      votesCount: json['votesCount'],
      commentsCount: json['commentsCount'],
      score: json['score'],
      privacy: json['privacy'],
      createAt: json['createAt'],
      updateAt: json['updateAt'],
      isDeleted: json['isDeleted'],
    );
  }
}
