import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/interact_repository.dart';

class VoteCommentUseCase extends UseCase<void, Params> {
  final InteractRepository _interactRepository;

  VoteCommentUseCase(this._interactRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _interactRepository.voteComment(params);
  }
}

class Params extends Equatable {
  final String userId;
  final String commentId;
  final int voteType;

  const Params({
    required this.userId,
    required this.commentId,
    required this.voteType,
  });

  @override
  List<Object?> get props => [userId, commentId, voteType];
}
