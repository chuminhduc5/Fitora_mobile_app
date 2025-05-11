import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_member_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';

class GetGroupMemberUseCase extends UseCase<List<GroupMemberEntity>, String> {
  final GroupRepository _groupRepository;
  GetGroupMemberUseCase(this._groupRepository);

  @override
  Future<Either<Failure, List<GroupMemberEntity>>> call(String params) async {
    return await _groupRepository.getGroupMembers(params);
  }
}