import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/post_repository.dart';

class CreatePostUseCase extends UseCase<void, Params> {
  final PostRepository _postRepository;

  CreatePostUseCase(this._postRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _postRepository.createPost(params);
  }
}

class Params extends Equatable {
  final String content;
  final String mediaUrl;
  final int privacy;
  final String groupId;

  const Params({
    required this.content,
    required this.mediaUrl,
    required this.privacy,
    required this.groupId,
  });

  @override
  List<Object?> get props => [content, mediaUrl, privacy, groupId];
}
