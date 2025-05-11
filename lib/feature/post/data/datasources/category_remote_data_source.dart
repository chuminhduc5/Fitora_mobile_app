import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/categories/create_category_request.dart';

abstract class CategoryRemoteDataSource {
  Future<void> createCategory(CreateCategoryRequest request);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final DioClient _dioClient;

  const CategoryRemoteDataSourceImpl(this._dioClient);

  @override
  Future<void> createCategory(CreateCategoryRequest request) async {
    try {
      await _dioClient.post(ApiUrl.createCategory, data: request.toJson());
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }
}