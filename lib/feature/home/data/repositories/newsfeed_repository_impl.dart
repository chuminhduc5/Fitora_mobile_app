import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/data/models/newsfeed_model.dart';
import 'package:fitora_mobile_app/core/domain/entities/newsfeed_entity.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/newsfeed/newsfeed_mapper.dart';
import 'package:fitora_mobile_app/feature/home/data/datasources/newsfeed_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/home/doamin/repositories/newsfees_repository.dart';

class NewsfeedRepositoryImpl implements NewsfeedRepository {
  final NewsfeedRemoteDataSource _newsfeedRemoteDataSource;

  const NewsfeedRepositoryImpl(this._newsfeedRemoteDataSource);

  @override
  Future<Either<Failure, List<NewsfeedEntity>>> getNewsfeed(
      String cursor, int limit) async {
    try {
      final data = await _newsfeedRemoteDataSource.fetchNewsfeed(cursor, limit);
      return data.fold(
        (error) {
          return Left(error);
        },
        (data) {
          var newsfeed = List.from(data)
              .map((item) =>
                  NewsfeedMapper.toEntity(NewsfeedModel.fromJson(item)))
              .toList();
          return Right(newsfeed);
        },
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
