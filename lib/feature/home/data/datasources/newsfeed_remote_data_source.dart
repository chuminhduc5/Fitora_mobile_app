import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/data/models/newsfeed_model.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';

abstract class NewsfeedRemoteDataSource {
  Future<List<NewsfeedModel>> fetchNewsfeed();
}

class NewsfeedRemoteDataSourceImpl implements NewsfeedRemoteDataSource {
  final DioClient _dioClient;

  const NewsfeedRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<NewsfeedModel>> fetchNewsfeed() async {
    try {
      var response =
          await _dioClient.get('${ApiUrl.newsFeed}?Cursor=1&Limit=1');
      final List<NewsfeedModel> newsfeed = response.data
          .map<NewsfeedModel>((json) => NewsfeedModel.fromJson(json))
          .toList();
      return newsfeed;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
