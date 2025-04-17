import 'package:fitora_mobile_app/feature/post/data/models/responses/comment_model.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';

class CommentMapper {
  static CommentEntity toEntity(CommentModel comment) {
    return CommentEntity(
      id: comment.id,
      userId: comment.userId,
      postId: comment.postId,
      parentCommentId: comment.parentCommentId,
      content: comment.content,
      mediaUrl: comment.mediaUrl,
      votes: comment.votes,
      replyCount: comment.replyCount,
      score: comment.score,
      user: comment.user.toEntity(),
      userVoteType: comment.userVoteType,
      isDeleted: comment.isDeleted,
    );
  }
}
