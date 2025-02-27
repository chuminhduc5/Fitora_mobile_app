import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/domain/entities/newsfeed_entity.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/home/doamin/repositories/newsfees_repository.dart';

class GetNewsfeedUseCase extends UseCase<List<NewsfeedEntity>, NoParams> {
  final NewsfeedRepository _newsfeedRepository;

  GetNewsfeedUseCase(this._newsfeedRepository);

  @override
  Future<Either<Failure, List<NewsfeedEntity>>> call(NoParams params) async {
    return await _newsfeedRepository.getNewsfeed();
  }
}
