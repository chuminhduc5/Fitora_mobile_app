import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/posts/create_post_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/posts/save_post_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/posts/update_post_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/responses/post_model.dart';

abstract class PostRemoteDataSource {
  Future<PostModel> fetchPost();

  Future<void> createPost(CreatePostRequest request);

  Future<void> updatePost(UpdatePostRequest request);

  Future<void> deletePost(String id);

  Future<List<PostModel>> fetchNewsfeed();

  Future<List<PostModel>> fetchPersonal(String userId);

  Future<List<PostModel>> fetchTrendingFeed();

  Future<void> savePost(SavePostRequest request);

  Future<List<PostModel>> fetchSavedPost();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient _dioClient;

  PostRemoteDataSourceImpl(this._dioClient);

  @override
  Future<PostModel> fetchPost() async {
    try {
      var response = await _dioClient.get(ApiUrl.post);
      final post = response.data;
      return post;
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> createPost(CreatePostRequest request) async {
    try {
      await _dioClient.post(ApiUrl.createPost, data: request.toJson());
      return;
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> updatePost(UpdatePostRequest request) async {
    try {
      await _dioClient.put(
        '${ApiUrl.updatePost}/id=${request.id}',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      logger.e('Update Post failed: ${e.message}');
      throw ServerException();
    }
  }

  @override
  Future<void> deletePost(String id) async {
    try {
      await _dioClient.delete('${ApiUrl.deletePost}/id');
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> fetchNewsfeed() async {
    try {
      var response = await _dioClient.get(ApiUrl.getExplorePosts);
      final data = response.data['data'];
      if (data != null && data['data'] is List) {
        final List<PostModel> newsfeed = (data['data'] as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        // logg.i("Newsfeed: $newsfeed");
        return newsfeed;
      } else {
        throw Exception("Invalid response format");
      }
    } on DioException catch (e) {
      logger.e('Fetch Newsfeed failed: ${e.message}');
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> fetchPersonal(String userId) async {
    try {
      var response = await _dioClient.get('${ApiUrl.personal}?Id=$userId');
      final data = response.data['data'];
      if (data != null && data['data'] is List) {
        final List<PostModel> personal = (data['data'] as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        // logg.i("Newsfeed: $newsfeed");
        return personal;
      } else {
        throw Exception("Invalid response format");
      }
    } on DioException catch (e) {
      logger.e('Fetch Newsfeed failed: ${e.message}');
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> fetchTrendingFeed() async {
    try {
      var response = await _dioClient.get(ApiUrl.getTrendingPost);
      final data = response.data['data'];
      if (data != null && data['data'] is List) {
        final List<PostModel> newsfeed = (data['data'] as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        logg.i("Newsfeed: $newsfeed");
        return newsfeed;
      } else {
        throw Exception("Invalid response format");
      }
    } on DioException catch (e) {
      logger.e('Fetch Newsfeed failed: ${e.message}');
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> fetchSavedPost() async {
    try {
      var response = await _dioClient.get(ApiUrl.getSavedPost);
      final data = response.data['data'];
      if (data != null && data['data'] is List) {
        final List<PostModel> newsfeed = (data['data'] as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        logg.i("Newsfeed: $newsfeed");
        return newsfeed;
      } else {
        throw Exception("Invalid response format");
      }
    } on DioException catch (e) {
      logger.e('Fetch Newsfeed failed: ${e.message}');
      throw ServerException();
    }
  }

  @override
  Future<void> savePost(SavePostRequest request) async {
    try {
      await _dioClient.post(ApiUrl.savePost, data: request.toJson());
    } on DioException catch(e) {
      throw ServerException();
    }
  }
}
