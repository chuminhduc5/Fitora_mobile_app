import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_member_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';

class CreateGroupUseCase extends UseCase<GroupMemberEntity, Params> {
  final GroupRepository _groupRepository;
  CreateGroupUseCase(this._groupRepository);

  @override
  Future<Either<Failure, GroupMemberEntity>> call(Params params) async {
    return await _groupRepository.createGroup(params);
  }
}

class Params extends Equatable {
  final String name;
  final String description;
  final int privacy;
  final bool requirePostApproval;
  final String coverImageUrl;
  final String avatarUrl;

  const Params({
    required this.name,
    required this.description,
    required this.privacy,
    required this.requirePostApproval,
    required this.coverImageUrl,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        privacy,
        requirePostApproval,
        coverImageUrl,
        avatarUrl,
      ];
}
