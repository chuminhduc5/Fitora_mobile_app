import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/friends/data/models/friend_model.dart';
import 'package:fitora_mobile_app/feature/friends/data/models/friend_request_model.dart';

abstract class FriendRemoteDataSource {
  Future<void> addFriend(String id);
  Future<void> acceptFriend(String id);
  Future<List<FriendModel>> fetchFriend();
  Future<void> deleteFriend(String id);
  Future<void> unfriend(String id);
  Future<List<FriendRequestModel>> fetchSentFriendRequest();
  Future<List<FriendRequestModel>> fetchReceivedFriendRequest();
}

class FriendRemoteDataSourceImpl implements FriendRemoteDataSource {
  final DioClient _dioClient;
  const FriendRemoteDataSourceImpl(this._dioClient);
  @override
  Future<void> acceptFriend(String id) async {
    try {
      await _dioClient.put("${ApiUrl.acceptFriend}?id=$id");
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> addFriend(String id) async {
    try {
      await _dioClient.post("${ApiUrl.addFriend}?id=$id");
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteFriend(String id) async {
    try {
      await _dioClient.delete("${ApiUrl.deleteFriend}?id=$id");
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<FriendModel>> fetchFriend() async {
    try {
      final response = await _dioClient.get(ApiUrl.friend);
      final friends = response.data;
      return friends;
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<FriendRequestModel>> fetchReceivedFriendRequest() async {
    try {
      final response = await _dioClient.get(ApiUrl.getReceivedFriendRequests);
      final results = response.data;
      return results;
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<FriendRequestModel>> fetchSentFriendRequest() async {
    try {
      final response = await _dioClient.get(ApiUrl.getSentFriendRequests);
      final results = response.data;
      return results;
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> unfriend(String id) async {
    try {
      await _dioClient.put("${ApiUrl.unfriend}?id=$id");
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }
}