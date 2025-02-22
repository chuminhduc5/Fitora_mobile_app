import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/home/doamin/entities/news_fees_entity.dart';

abstract class NewsFeesRepository {
  Future<Either<Failure, List<NewsFeedEntity>>> getNewsFeed();
}