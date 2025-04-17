import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/helper/mapper/profile/profile_mapper.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/profile/data/models/requests/update_profile_request.dart';
import 'package:fitora_mobile_app/feature/profile/data/models/responses/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> fetchProfile();

  Future<void> updateProfile(UpdateProfileRequest request);
  Future<ProfileModel> fetchPersonal(String userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient _dioClient;

  ProfileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ProfileModel> fetchProfile() async {
    try {
      final response = await _dioClient.get(ApiUrl.profile);
      final data = response.data["data"];
      final profile = ProfileModel.fromJson(data);
      return profile;
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }

  @override
  Future<void> updateProfile(UpdateProfileRequest request) async {
    try {
      print("🔍 Request body: ${jsonEncode(request.toJson())}");
      await _dioClient.put(
        ApiUrl.updateProfile,
        data: request.toJson(),
      );
      return;
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> fetchPersonal(String userId) async {
    try {
      final response = await _dioClient.get('${ApiUrl.getUser}?GetId=$userId');
      final data = response.data["data"];
      final profile = ProfileModel.fromJson(data);
      return profile;
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }
}
