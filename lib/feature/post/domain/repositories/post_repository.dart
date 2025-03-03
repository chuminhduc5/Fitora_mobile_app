import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

abstract class PostRepository {
  Future<Either<Failure, PostEntity>> getPost();
  Future<Either<Failure, void>> createPost(CreatePostParams params);
  Future<Either<Failure, void>> updatePost(UpdatePostParams params);
  Future<Either<Failure, void>> deletePost(String id);
  Future<Either<Failure, List<PostEntity>>> getNewsFeed();
  Future<Either<Failure, List<PostEntity>>> getPersonal();
}