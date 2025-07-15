import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/data/models/requests/profile/update_profile_request.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/user_model.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/user_profile_model.dart';

abstract class UserRemoteDataSource {
  Future<UserProfileModel> fetchProfile();

  Future<void> updateProfile(UpdateProfileRequest request);

  Future<UserProfileModel> fetchPersonal(String userId);

  Future<List<UserModel>> fetchUsers();

  Future<List<UserModel>> searchUsers(String keySearch);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient _dioClient;

  const UserRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UserProfileModel> fetchProfile() async {
    try {
      final response = await _dioClient.get(ApiUrl.profile);
      final data = response.data["data"];
      final profile = UserProfileModel.fromJson(data);
      return profile;
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }

  @override
  Future<void> updateProfile(UpdateProfileRequest request) async {
    try {
      await _dioClient.put(
        ApiUrl.updateProfile,
        data: request.toJson(),
      );
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }

  @override
  Future<UserProfileModel> fetchPersonal(String userId) async {
    try {
      final response = await _dioClient.get(
        ApiUrl.getUser,
        queryParameters: {"GetId": userId},
      );
      final data = response.data["data"];
      final profile = UserProfileModel.fromJson(data);
      return profile;
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _dioClient.get(
        ApiUrl.getUsers,
        queryParameters: {"PageSize": 30},
      );
      final data = response.data['data'];
      if (data != null && data['data'] is List) {
        final users =
            (data['data'] as List).map((i) => UserModel.fromJson(i)).toList();
        logg.i("Danh sách người dùng (RemoteDataSource): $users");
        return users;
      } else {
        throw Exception("Không tồn tại người dùng nào!");
      }
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> searchUsers(String keySearch) async {
    try {
      final response = await _dioClient.get(
        ApiUrl.getUsers,
        queryParameters: {"KeySearch": keySearch},
      );
      final data = response.data['data'];
      if (data != null && data['data'] is List) {
        final users =
            (data['data'] as List).map((i) => UserModel.fromJson(i)).toList();
        logg.i("Danh sách người dùng (RemoteDataSource): $users");
        return users;
      } else {
        throw Exception("Không tồn tại người dùng nào!");
      }
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }
}
