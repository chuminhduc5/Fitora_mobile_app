import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/managed_group_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';

class GetJoinedGroupUseCase extends UseCase<List<ManagedGroupEntity>, NoParams> {
  final GroupRepository _groupRepository;
  GetJoinedGroupUseCase(this._groupRepository);
  @override
  Future<Either<Failure, List<ManagedGroupEntity>>> call(NoParams params) async {
    return await _groupRepository.getJoinedGroup();
  }
}