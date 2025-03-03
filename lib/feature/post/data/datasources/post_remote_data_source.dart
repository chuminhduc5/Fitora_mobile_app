import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/create_post_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/update_post_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/responses/post_model.dart';

abstract class PostRemoteDataSource {
  Future<PostModel> fetchPost();
  Future<void> createPost(CreatePostRequest model);
  Future<void> updatePost(UpdatePostRequest model);
  Future<void> deletePost(String id);
  Future<List<PostModel>> fetchNewsfeed();
  Future<List<PostModel>> fetchPersonal();
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final DioClient _dioClient;

  PostRemoteDataSourceImpl(this._dioClient);

  @override
  Future<PostModel> fetchPost() async {
    var response = await _dioClient.get('${ApiUrl.post}?Cursor=1&Limit=1)');
    final post = response.data;
    return post;
  }

  @override
  Future<void> createPost(CreatePostRequest model) async {
    try {
      await _dioClient.post(
        ApiUrl.createPost,
        data: model.toJson(),
      );
      return;
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> updatePost(UpdatePostRequest model) async {
    try {
      await _dioClient.put(
        '${ApiUrl.updatePost}/id=${model.id}',
        data: model.toJson(),
      );
    } on DioException catch (e) {
      logger.e('Update Post failed: ${e.message}');
      throw ServerException();
    }
  }

  @override
  Future<void> deletePost(String id) async {
    try {
      await _dioClient.delete(ApiUrl.deletePost);
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> fetchNewsfeed() async {
    try {
      var response = await _dioClient.get('${ApiUrl.newsFeed}?Cursor=1&Limit=1)');
      final List<PostModel> newsfeed = response.data
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
      return newsfeed;
    } on DioException catch (e) {
      logger.e('Fetch Newsfeed failed: ${e.message}');
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> fetchPersonal() async {
    try {
      var response = await _dioClient.get('${ApiUrl.personal}?Cursor=1&Limit=1)');
      final List<PostModel> personal = response.data
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
      return personal;
    } on DioException catch (e) {
      logger.e('Fetch Newsfeed failed: ${e.message}');
      throw ServerException();
    }
  }
}
