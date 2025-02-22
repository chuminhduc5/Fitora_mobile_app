import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/home/doamin/entities/news_fees_entity.dart';
import 'package:fitora_mobile_app/feature/home/doamin/repositories/news_fees_repository.dart';

class NewsFeedRepositoryImpl implements NewsFeesRepository {
  @override
  Future<Either<Failure, List<NewsFeedEntity>>> getNewsFeed() async {
    throw UnimplementedError();
  }
}