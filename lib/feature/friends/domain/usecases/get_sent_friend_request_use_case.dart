import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_request_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/repositories/friend_repository.dart';

class GetSentFriendRequestUseCase extends UseCase<List<FriendRequestEntity>, NoParams> {
  final FriendRepository _friendRepository;
  GetSentFriendRequestUseCase(this._friendRepository);

  @override
  Future<Either<Failure, List<FriendRequestEntity>>> call(NoParams params) async {
    return await _friendRepository.getSentFriendRequest();
  }
}