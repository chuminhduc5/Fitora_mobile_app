import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/repositories/friend_repository.dart';

class GetFriendUseCase extends UseCase<List<FriendEntity>, NoParams> {
  final FriendRepository _friendRepository;
  GetFriendUseCase(this._friendRepository);

  @override
  Future<Either<Failure, List<FriendEntity>>> call(NoParams params) async {
    return await _friendRepository.getFriend();
  }
}