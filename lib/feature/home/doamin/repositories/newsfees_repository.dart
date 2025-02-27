import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/domain/entities/newsfeed_entity.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';

abstract class NewsfeedRepository {
  Future<Either<Failure, List<NewsfeedEntity>>> getNewsfeed();
}
