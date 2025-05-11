import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/post_repository.dart';

class DeletePostUseCase extends UseCase<void, String> {
  final PostRepository _postRepository;
  DeletePostUseCase(this._postRepository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _postRepository.deletePost(params);
  }
}