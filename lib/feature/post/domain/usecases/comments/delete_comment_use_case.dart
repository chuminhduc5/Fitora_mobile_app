import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/comment_repository.dart';

class DeleteCommentUseCase extends UseCase<void, String> {
  final CommentRepository _commentRepository;
  DeleteCommentUseCase(this._commentRepository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _commentRepository.deleteComment(params);
  }
}