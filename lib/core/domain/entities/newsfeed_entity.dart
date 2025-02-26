import 'package:equatable/equatable.dart';

class NewsfeedEntity extends Equatable {
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

  const NewsfeedEntity({
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

  @override
  List<Object?> get props => [
        id,
        userId,
        groupId,
        content,
        mediaUrl,
        votesCount,
        commentsCount,
        score,
        privacy,
        createAt,
        updateAt,
        isDeleted,
      ];
}
