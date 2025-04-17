import 'package:fitora_mobile_app/feature/post/data/models/responses/post_model.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';

class PostMapper {
  static PostEntity toEntity(PostModel post) {
    return PostEntity(
      id: post.id,
      groupId: post.groupId,
      categoryId: post.categoryId,
      categoryName: post.categoryName,
      content: post.content,
      mediaUrl: post.mediaUrl,
      votesCount: post.votesCount,
      commentsCount: post.commentsCount,
      score: post.score,
      privacy: post.privacy,
      createAt: post.createAt,
      updateAt: post.updateAt,
      isDeleted: post.isDeleted,
      user: post.user.toEntity(),
      userVoteType: post.userVoteType,
    );
  }
}
