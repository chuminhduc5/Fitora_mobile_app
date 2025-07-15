import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/comments/create_comment_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/comments/update_comment_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/responses/comment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> fetchComment(String postId);

  Future<CommentModel> createComment(CreateCommentRequest request);

  Future<void> updateComment(UpdateCommentRequest request);

  Future<void> deleteComment(String id);

  Future<List<CommentModel>> fetchRepliesComment(String parentCommentId);
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final DioClient _dioClient;

  const CommentRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<CommentModel>> fetchComment(String postId) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final userId = pref.getString('userId');
      final response = await _dioClient.get(
        ApiUrl.getCommentByPost,
        queryParameters: {"UserId": userId, "PostId": postId},
      );
      final List<dynamic> data = response.data['data']['data'];

      final comments = data.map((e) => CommentModel.fromJson(e)).toList();

      return comments;
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<CommentModel> createComment(CreateCommentRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiUrl.createComment,
        data: request.toJson(),
      );
      final comment = CommentModel.fromJson(response.data['data']);
      return comment;
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> updateComment(UpdateCommentRequest request) async {
    try {
      await _dioClient.put(ApiUrl.createComment, data: request.toJson());
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteComment(String id) async {
    try {
      _dioClient.delete(
        ApiUrl.deleteComment,
        queryParameters: {"id": id},
      );
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<CommentModel>> fetchRepliesComment(String parentCommentId) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final userId = pref.getString('userId');
      final response = await _dioClient.get(
        ApiUrl.getCommentReplies,
        queryParameters: {"UserId": userId, "ParentCommentId": parentCommentId},
      );
      final List<dynamic> data = response.data['data']['data'];

      final comments = data.map((e) => CommentModel.fromJson(e)).toList();

      return comments;
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
