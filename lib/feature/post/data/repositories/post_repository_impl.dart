import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/cache/secure_local_storage.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/post/post_mapper.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/post_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/posts/create_post_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/posts/save_post_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/posts/update_post_request.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/post_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _postRemoteDataSource;
  final SecureLocalStorage _secureLocalStorage;
  final HiveLocalStorage _hiveLocalStorage;

  const PostRepositoryImpl(
    this._postRemoteDataSource,
    this._secureLocalStorage,
    this._hiveLocalStorage,
  );

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
        content: params.content,
        mediaUrl: params.mediaUrl,
        privacy: params.privacy,
        groupId: params.groupId,
        categoryId: params.categoryId,
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
        isApproved: params.isApproved,
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
      final results = await _postRemoteDataSource.fetchNewsfeed();
      final newsfeed = results.map((i) => PostMapper.toEntity(i)).toList();
      //newsfeed.sort((a, b) => b.createAt.compareTo(a.createAt));

      final user = await _postRemoteDataSource.fetchProfile();
      await _secureLocalStorage.save(key: "user_id", value: user.userInfo.id);
      await _hiveLocalStorage.save(key: "user", value: user, boxName: "cache");
      logg.i("Thông tin người dùng: $user");

      return Right(newsfeed);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getExploreFeed() async {
    try {
      final results = await _postRemoteDataSource.fetchExploreFeed();
      final exploreFeed = results.map((i) => PostMapper.toEntity(i)).toList();
      //exploreFeed.sort((a, b) => b.createAt.compareTo(a.createAt));

      final user = await _postRemoteDataSource.fetchProfile();
      await _secureLocalStorage.save(key: "user_id", value: user.userInfo.id);
      await _hiveLocalStorage.save(key: "user", value: user, boxName: "cache");
      logg.i("Thông tin người dùng: $user");

      return Right(exploreFeed);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getTrendingFeed() async {
    try {
      final results = await _postRemoteDataSource.fetchTrendingFeed();
      final trendingFeed = results.map((i) => PostMapper.toEntity(i)).toList();
      //newsfeed.sort((a, b) => b.createAt.compareTo(a.createAt));
      return Right(trendingFeed);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPersonal(String userId) async {
    try {
      final result = await _postRemoteDataSource.fetchPersonal(userId);
      final personal = result.map((item) => PostMapper.toEntity(item)).toList();
      return Right(personal);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> savePost(SavePostParams params) async {
    try {
      final result = await _postRemoteDataSource.savePost(SavePostRequest(
        userId: params.userId,
        postId: params.postId,
      ));
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getSavedPost() async {
    try {
      final results = await _postRemoteDataSource.fetchSavedPost();
      final posts = results.map((i) => PostMapper.toEntity(i)).toList();
      return Right(posts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
