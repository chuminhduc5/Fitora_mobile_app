import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/interact/vote_comment_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/interact/vote_post_request.dart';

abstract class InteractRemoteDataSource {
  Future<void> votePost(VotePostRequest request);
  Future<void> voteComment(VoteCommentRequest request);
}

class InteractRemoteDataSourceImpl implements InteractRemoteDataSource {
  final DioClient _dioClient;

  const InteractRemoteDataSourceImpl(this._dioClient);

  @override
  Future<void> votePost(VotePostRequest request) async {
    try {
      await _dioClient.put(ApiUrl.votePost, data: request.toJson());
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> voteComment(VoteCommentRequest request) async {
    try {
      await _dioClient.put(ApiUrl.voteComment, data: request.toJson());
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }
}