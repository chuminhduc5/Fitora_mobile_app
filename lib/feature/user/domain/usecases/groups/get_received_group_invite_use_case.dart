import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/received_group_invite_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';

class GetReceivedGroupInviteUseCase extends UseCase<List<ReceivedGroupInviteEntity>, NoParams> {
  final GroupRepository _groupRepository;
  GetReceivedGroupInviteUseCase(this._groupRepository);

  @override
  Future<Either<Failure, List<ReceivedGroupInviteEntity>>> call(NoParams params) async {
    return await _groupRepository.getReceivedGroupInvite();
  }
}