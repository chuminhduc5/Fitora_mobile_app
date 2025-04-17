import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_request_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/recommend_user_entity.dart';

abstract class FriendRepository {
  Future<Either<Failure, void>> addFriend(String userId);
  Future<Either<Failure, void>> acceptFriend(String userId);
  Future<Either<Failure, List<FriendEntity>>> getFriend();
  Future<Either<Failure, void>> deleteFriend(String userId);
  Future<Either<Failure, void>> unfriend(String userId);
  Future<Either<Failure, List<FriendRequestEntity>>> getSentFriendRequest();
  Future<Either<Failure, List<FriendRequestEntity>>> getReceivedFriendRequest();

  Future<Either<Failure, List<RecommendUserEntity>>> getRecommendUser();
}