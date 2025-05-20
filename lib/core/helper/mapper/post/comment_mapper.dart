import 'package:fitora_mobile_app/feature/post/data/models/responses/comment_model.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';

class CommentMapper {
  static CommentEntity toEntity(CommentModel comment) {
    // return CommentEntity(
    //   userId: comment.userId,
    //   postId: comment.postId,
    //   content: comment.content,
    //   mediaUrl: comment.mediaUrl,
    //   voteCount: comment.voteCount,
    //   commentVotes: comment.commentVotes,
    //   replyCount: comment.replyCount,
    //   isDeleted: comment.isDeleted,
    //   id: comment.id,
    //   createdAt: comment.createdAt,
    //   lastModified: comment.lastModified,
    // );
    return CommentEntity(
      id: comment.id,
      userId: comment.userId,
      postId: comment.postId,
      post: comment.post,
      parentCommentId: comment.parentCommentId,
      parentComment: comment.parentComment,
      content: comment.content,
      mediaUrl: comment.mediaUrl,
      voteCount: comment.voteCount,
      score: comment.score,
      replyCount: comment.replyCount,
      commentVotes: comment.commentVotes,
      userVoteType: comment.userVoteType,
      isDeleted: comment.isDeleted,
      createdBy: comment.createdBy,
      createdAt: comment.createdAt,
      lastModified: comment.lastModified,
      lastModifiedBy: comment.lastModifiedBy,
      user: comment.user?.toEntity(),
    );
  }
}
