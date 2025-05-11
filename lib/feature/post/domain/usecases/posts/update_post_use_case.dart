import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/post_repository.dart';

class UpdatePostUseCase extends UseCase<void, Params> {
  final PostRepository _postRepository;

  UpdatePostUseCase(this._postRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _postRepository.updatePost(params);
  }
}

class Params extends Equatable {
  final String id;
  final String content;
  final String mediaUrl;
  final int privacy;

  const Params({
    required this.id,
    required this.content,
    required this.mediaUrl,
    required this.privacy,
  });

  @override
  List<Object?> get props => [content, mediaUrl, privacy];
}
