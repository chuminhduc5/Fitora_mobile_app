import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';

class DeleteGroupUseCase extends UseCase<void, String> {
  final GroupRepository _groupRepository;

  DeleteGroupUseCase(this._groupRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _groupRepository.deleteGroup(params);
  }
}
