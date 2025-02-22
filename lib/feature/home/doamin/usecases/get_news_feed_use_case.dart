import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/home/doamin/entities/news_fees_entity.dart';
import 'package:fitora_mobile_app/feature/home/doamin/repositories/news_fees_repository.dart';

class GetNewsFeedUseCase extends UseCase<List<NewsFeedEntity>, NoParams> {
  final NewsFeesRepository _newsFeesRepository;

  GetNewsFeedUseCase(this._newsFeesRepository);

  @override
  Future<Either<Failure, List<NewsFeedEntity>>> call(NoParams params) async {
    return await _newsFeesRepository.getNewsFeed();
  }
}
