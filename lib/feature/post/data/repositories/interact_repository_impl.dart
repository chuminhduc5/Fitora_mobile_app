import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/interact_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/interact/vote_comment_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/interact/vote_post_request.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/interact_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

class InteractRepositoryImpl implements InteractRepository {
  final InteractRemoteDataSource _interactRemoteDataSource;

  const InteractRepositoryImpl(this._interactRemoteDataSource);

  @override
  Future<Either<Failure, void>> votePost(VotePostParams params) async {
    try {
      final result = await _interactRemoteDataSource.votePost(
        VotePostRequest(
          userId: params.userId,
          postId: params.postId,
          voteType: params.voteType,
        ),
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> voteComment(VoteCommentParams params) async {
    try {
      final result = await _interactRemoteDataSource.voteComment(
        VoteCommentRequest(
          userId: params.userId,
          commentId: params.commentId,
          voteType: params.voteType,
        ),
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
