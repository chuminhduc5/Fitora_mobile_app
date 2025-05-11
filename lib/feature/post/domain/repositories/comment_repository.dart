import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentEntity>>> getComment(String postId);
  Future<Either<Failure, void>> createComment(CreateCommentParams params);
  Future<Either<Failure, void>> updateComment(UpdateCommentParams params);
}