import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/post_repository.dart';

class SavePostUseCase extends UseCase<void, Params> {
  final PostRepository _postRepository;

  SavePostUseCase(this._postRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _postRepository.savePost(params);
  }
}

class Params extends Equatable {
  final String userId;
  final String postId;

  const Params({required this.userId, required this.postId});

  @override
  List<Object?> get props => [userId, postId];
}
