import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/categories/create_category_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/responses/categoty_model.dart';

abstract class CategoryRemoteDataSource {
  Future<void> createCategory(CreateCategoryRequest request);

  Future<CategoryModel> getCategoryById(String id);

  Future<void> followCategory(String id);

  Future<void> unfollowCategory(String id);

  Future<List<CategoryModel>> getFollowed();

  Future<List<CategoryModel>> getTrending();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final DioClient _dioClient;

  const CategoryRemoteDataSourceImpl(this._dioClient);

  @override
  Future<void> createCategory(CreateCategoryRequest request) async {
    try {
      await _dioClient.post(ApiUrl.createCategory, data: request.toJson());
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<CategoryModel> getCategoryById(String id) async {
    try {
      final response = await _dioClient.get(
        ApiUrl.getCategoryById,
        queryParameters: {"id": id},
      );
      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> followCategory(String id) async {
    try {
      await _dioClient.post(ApiUrl.followCategory, data: jsonEncode(id));
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> unfollowCategory(String id) async {
    try {
      await _dioClient.post(ApiUrl.unfollowCategory, data: jsonEncode(id));
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<CategoryModel>> getFollowed() async {
    try {
      final response = await _dioClient.get(ApiUrl.getFollowed);
      final data = response.data['data'];
      if (data != null && data is List) {
        final followed =
            data.map((json) => CategoryModel.fromJson(json)).toList();
        return followed;
      } else {
        throw Exception("Invalid response format");
      }
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<CategoryModel>> getTrending() async {
    try {
      final response = await _dioClient.get(ApiUrl.getTrending);
      final data = response.data['data'];
      if (data != null && data is List) {
        final trending =
            data.map((json) => CategoryModel.fromJson(json)).toList();
        return trending;
      } else {
        throw Exception("Invalid response format");
      }
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
