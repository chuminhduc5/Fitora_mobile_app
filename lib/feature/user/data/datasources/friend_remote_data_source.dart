import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/friend_model.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/friend_request_model.dart';

abstract class FriendRemoteDataSource {
  Future<void> addFriend(String userId);
  Future<void> acceptFriend(String userId);
  Future<List<FriendModel>> fetchFriend();
  Future<void> deleteFriend(String userId);
  Future<void> unfriend(String userId);
  Future<List<FriendRequestModel>> fetchSentFriendRequest();
  Future<List<FriendRequestModel>> fetchReceivedFriendRequest();
  //Future<List<RecommendUserModel>> fetchRecommendUser();
}

class FriendRemoteDataSourceImpl implements FriendRemoteDataSource {
  final DioClient _dioClient;
  const FriendRemoteDataSourceImpl(this._dioClient);
  @override
  Future<void> acceptFriend(String userId) async {
    try {
      await _dioClient.put(ApiUrl.acceptFriend, data: jsonEncode(userId));
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> addFriend(String userId) async {
    try {
      await _dioClient.post(ApiUrl.addFriend, data: jsonEncode(userId));
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteFriend(String userId) async {
    try {
      await _dioClient.delete("${ApiUrl.deleteFriend}?id=$userId");
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<FriendModel>> fetchFriend() async {
    try {
      final response = await _dioClient.get(ApiUrl.friend);
      final results = response.data['data'];
      if (results != null && results['data'] is List) {
        final friends = (results['data'] as List).map((i) => FriendModel.fromJson(i)).toList();
        logger.i("Danh sách lời mời kết bạn: $friends");
        return friends;
      } else {
        throw Exception("Invalid response format");
      }
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<FriendRequestModel>> fetchReceivedFriendRequest() async {
    try {
      final response = await _dioClient.get(ApiUrl.getReceivedFriendRequests);
      final results = response.data['data'];
      if (results != null && results['data'] is List) {
        final received = (results['data'] as List).map((i) => FriendRequestModel.fromJson(i)).toList();
        logger.i("Danh sách lời mời kết bạn: $received");
        return received;
      } else {
        throw Exception("Invalid response format");
      }
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
      return results.map((json) => FriendRequestModel.fromJson(json));
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> unfriend(String userId) async {
    try {
      await _dioClient.put("${ApiUrl.unfriend}?id=$userId");
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  // @override
  // Future<List<RecommendUserModel>> fetchRecommendUser() async {
  //   try {
  //     final response = await _dioClient.get(ApiUrl.getRecommendUser);
  //     final results = response.data['data'];
  //     if (results != null && results['data'] is List) {
  //       final users = (results['data'] as List).map((json) => RecommendUserModel.fromJson(json)).toList();
  //       logg.i("Users: $users");
  //       return users;
  //     } else {
  //       throw Exception("Invalid response format");
  //     }
  //   } on DioException catch(e) {
  //     logger.e(e);
  //     throw ServerException();
  //   }
  // }
}