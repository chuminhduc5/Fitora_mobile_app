import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/friend/friend_mapper.dart';
import 'package:fitora_mobile_app/core/helper/mapper/friend/friend_request_mapper.dart';
import 'package:fitora_mobile_app/feature/friends/data/datasources/friend_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_request_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/repositories/friend_repository.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FriendRemoteDataSource _friendRemoteDataSource;

  const FriendRepositoryImpl(this._friendRemoteDataSource);

  @override
  Future<Either<Failure, void>> acceptFriend(String userId) async {
    try {
      final result = await _friendRemoteDataSource.acceptFriend(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addFriend(String userId) async {
    try {
      final result = await _friendRemoteDataSource.addFriend(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFriend(String userId) async {
    try {
      final result = await _friendRemoteDataSource.deleteFriend(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FriendEntity>>> getFriend() async {
    try {
      final result = await _friendRemoteDataSource.fetchFriend();
      final friends = result.map((i) => FriendMapper.toEntity(i)).toList();
      return Right(friends);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FriendRequestEntity>>> getReceivedFriendRequest() async {
    try {
      final result = await _friendRemoteDataSource.fetchReceivedFriendRequest();
      final request = result.map((i) => FriendRequestMapper.toEntity(i)).toList();
      return Right(request);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FriendRequestEntity>>> getSentFriendRequest() async {
    try {
      final result = await _friendRemoteDataSource.fetchSentFriendRequest();
      final request = result.map((i) => FriendRequestMapper.toEntity(i)).toList();
      return Right(request);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unfriend(String userId) async {
    try {
      final result = await _friendRemoteDataSource.unfriend(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
