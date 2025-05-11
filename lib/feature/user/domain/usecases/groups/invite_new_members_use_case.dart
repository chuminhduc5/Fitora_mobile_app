import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';

class InviteNewMembersUseCase extends UseCase<void, Params> {
  final GroupRepository _groupRepository;
  InviteNewMembersUseCase(this._groupRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _groupRepository.inviteNewMembers(params);
  }
}

class Params extends Equatable {
  final String groupId;
  final List<String> receiverUserIds;

  const Params({
    required this.groupId,
    required this.receiverUserIds,
  });

  @override
  List<Object?> get props => [groupId, receiverUserIds];
}
