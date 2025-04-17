import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/recommend_user_entity.dart';

import '../repositories/friend_repository.dart';

class GetRecommendUserUseCase extends UseCase<List<RecommendUserEntity>, NoParams> {
  final FriendRepository _friendRepository;
  GetRecommendUserUseCase(this._friendRepository);

  @override
  Future<Either<Failure, List<RecommendUserEntity>>> call(NoParams params) async {
    return await _friendRepository.getRecommendUser();
  }
}