import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/comment_repository.dart';

class UpdateCommentUseCase extends UseCase<void, Params> {
  final CommentRepository _commentRepository;

  UpdateCommentUseCase(this._commentRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _commentRepository.updateComment(params);
  }
}

class Params extends Equatable {
  final String id;
  final String content;
  final String mediaUrl;

  const Params({
    required this.id,
    required this.content,
    required this.mediaUrl,
  });

  @override
  List<Object?> get props => [id, content, mediaUrl];
}
