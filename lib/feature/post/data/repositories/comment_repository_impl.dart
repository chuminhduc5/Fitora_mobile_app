import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/cache/secure_local_storage.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/post/comment_mapper.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/comment_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/comments/create_comment_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/comments/update_comment_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/responses/comment_model.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/comment_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource _commentRemoteDataSource;
  final SecureLocalStorage _secureLocalStorage;
  final HiveLocalStorage _hiveLocalStorage;

  const CommentRepositoryImpl(
    this._commentRemoteDataSource,
    this._secureLocalStorage,
    this._hiveLocalStorage,
  );

  @override
  Future<Either<Failure, List<CommentEntity>>> getComment(String postId) async {
    try {
      final result = await _commentRemoteDataSource.fetchComment(postId);
      final comment = result.map((i) => CommentMapper.toEntity(i)).toList();
      return Right(comment);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CommentEntity>> createComment(
      CreateCommentParams params) async {
    try {
      final result = await _commentRemoteDataSource.createComment(
        CreateCommentRequest(
          postId: params.postId,
          parentCommentId: params.parentCommentId,
          content: params.content,
          mediaUrl: params.mediaUrl,
        ),
      );
      final comment = CommentMapper.toEntity(result);
      return Right(comment);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateComment(
      UpdateCommentParams params) async {
    try {
      final result = await _commentRemoteDataSource.updateComment(
        UpdateCommentRequest(
          id: params.id,
          content: params.content,
          mediaUrl: params.mediaUrl,
        ),
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(String id) async {
    try {
      final result = await _commentRemoteDataSource.deleteComment(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getRepliesComment(String parentCommentId) async {
    try {
      final result = await _commentRemoteDataSource.fetchRepliesComment(parentCommentId);
      final comment = result.map((i) => CommentMapper.toEntity(i)).toList();
      return Right(comment);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
