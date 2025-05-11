import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/comment_repository.dart';

class CreateCommentUseCase extends UseCase<void, Params> {
  final CommentRepository _commentRepository;

  CreateCommentUseCase(this._commentRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _commentRepository.createComment(params);
  }
}

class Params extends Equatable {
  final String postId;
  final String? parentCommentId;
  final String content;
  final String mediaUrl;

  const Params({
    required this.postId,
    this.parentCommentId,
    required this.content,
    required this.mediaUrl,
  });

  @override
  List<Object?> get props => [postId, parentCommentId, content, mediaUrl];
}
