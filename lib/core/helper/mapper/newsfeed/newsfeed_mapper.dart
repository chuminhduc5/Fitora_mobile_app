import 'package:fitora_mobile_app/core/data/models/newsfeed_model.dart';
import 'package:fitora_mobile_app/core/domain/entities/newsfeed_entity.dart';

class NewsfeedMapper {
  static NewsfeedEntity toEntity(NewsfeedModel newsfeed) {
    return NewsfeedEntity(
      id: newsfeed.id,
      userId: newsfeed.userId,
      groupId: newsfeed.groupId,
      content: newsfeed.content,
      mediaUrl: newsfeed.mediaUrl,
      votesCount: newsfeed.votesCount,
      commentsCount: newsfeed.commentsCount,
      score: newsfeed.score,
      privacy: newsfeed.privacy,
      createAt: newsfeed.createAt,
      updateAt: newsfeed.updateAt,
      isDeleted: newsfeed.isDeleted,
    );
  }
}
