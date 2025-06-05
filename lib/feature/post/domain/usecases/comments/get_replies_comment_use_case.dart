import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/comment_repository.dart';

class GetRepliesCommentUseCase extends UseCase<List<CommentEntity>, String> {
  final CommentRepository _commentRepository;

  GetRepliesCommentUseCase(this._commentRepository);

  @override
  Future<Either<Failure, List<CommentEntity>>> call(String params) async {
    return await _commentRepository.getRepliesComment(params);
  }
}