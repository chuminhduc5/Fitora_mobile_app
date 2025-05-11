import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

abstract class InteractRepository {
  Future<Either<Failure, void>> votePost(VotePostParams params);
  Future<Either<Failure, void>> voteComment(VoteCommentParams params);
}