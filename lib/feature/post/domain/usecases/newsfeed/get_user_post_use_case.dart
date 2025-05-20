import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/post_repository.dart';

class GetUserPostUseCase extends UseCase<List<PostEntity>, String> {
  final PostRepository _postRepository;

  GetUserPostUseCase(this._postRepository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(String params) async {
    return await _postRepository.getPersonal(params);
  }
}
