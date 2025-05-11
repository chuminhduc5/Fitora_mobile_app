import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/friend_repository.dart';

class AddFriendUseCase extends UseCase<void, String> {
  final FriendRepository _friendRepository;
  AddFriendUseCase(this._friendRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _friendRepository.addFriend(params);
  }
}