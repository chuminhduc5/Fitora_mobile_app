import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/friend_request_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/friend_repository.dart';

class GetReceivedFriendRequestUseCase extends UseCase<List<FriendRequestEntity>, NoParams> {
  final FriendRepository _friendRepository;
  GetReceivedFriendRequestUseCase(this._friendRepository);

  @override
  Future<Either<Failure, List<FriendRequestEntity>>> call(NoParams params) async {
    return await _friendRepository.getReceivedFriendRequest();
  }
}