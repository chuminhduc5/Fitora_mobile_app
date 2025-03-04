import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/post/post_mapper.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/post_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/create_post_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/update_post_request.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/post_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _postRemoteDataSource;

  const PostRepositoryImpl(this._postRemoteDataSource);

  @override
  Future<Either<Failure, PostEntity>> getPost() async {
    try {
      final result = await _postRemoteDataSource.fetchPost();
      final post = PostMapper.toEntity(result);
      return Right(post);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createPost(CreatePostParams params) async {
    try {
      final request = CreatePostRequest(
        params.content,
        params.mediaUrl,
        params.privacy,
        params.groupId,
      );
      final result = await _postRemoteDataSource.createPost(request);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updatePost(UpdatePostParams params) async {
    try {
      final request = UpdatePostRequest(
        id: params.id,
        content: params.content,
        mediaUrl: params.mediaUrl,
        privacy: params.privacy,
        groupId: params.groupId,
      );
      final result = await _postRemoteDataSource.updatePost(request);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(String id) async {
    try {
      final result = _postRemoteDataSource.deletePost(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getNewsFeed() async {
    try {
      final result = await _postRemoteDataSource.fetchNewsfeed();
      final newsfeed = result.map((item) => PostMapper.toEntity(item)).toList();
      return Right(newsfeed);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPersonal() async {
    try {
      final result = await _postRemoteDataSource.fetchPersonal();
      final personal = result.map((item) => PostMapper.toEntity(item)).toList();
      return Right(personal);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
