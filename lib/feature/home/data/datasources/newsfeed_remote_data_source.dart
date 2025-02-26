import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/constants/api_constant.dart';
import 'package:fitora_mobile_app/core/data/models/newsfeed_model.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';

abstract class NewsfeedRemoteDataSource {
  Future<Either<Failure, List<NewsfeedModel>>> fetchNewsfeed(String cursor, int limit);
}

class NewsfeedRemoteDataSourceImpl implements NewsfeedRemoteDataSource {
  @override
  Future<Either<Failure, List<NewsfeedModel>>> fetchNewsfeed(String cursor, int limit) async {
    try {
      var response = await getIt<DioClient>()
          .get('${ApiConstant.newsFeed}?Cursor=$cursor&Limit=$limit');
      final List<NewsfeedModel> newsfeed = response.data
          .map<NewsfeedModel>((json) => NewsfeedModel.fromJson(json))
          .toList();
      return Right(newsfeed);
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}