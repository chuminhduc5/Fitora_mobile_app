import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';

class GetGroupByIdUseCase extends UseCase<GroupResponseEntity, String> {
  final GroupRepository _groupRepository;
  GetGroupByIdUseCase(this._groupRepository);

  @override
  Future<Either<Failure, GroupResponseEntity>> call(String params) async {
    return await _groupRepository.getGroupById(params);
  }
}