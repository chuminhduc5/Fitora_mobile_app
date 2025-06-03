import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_member_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/managed_group_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/received_group_invite_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/usecase_params.dart';

abstract class GroupRepository {
  Future<Either<Failure, GroupMemberEntity>> createGroup(CreateGroupParams params);
  Future<Either<Failure, void>> updateGroup(UpdateGroupParams params);
  Future<Either<Failure, void>> deleteGroup(String groupId);
  Future<Either<Failure, GroupResponseEntity>> getGroupById(String id);
  Future<Either<Failure, List<GroupMemberEntity>>> getGroupMembers(String groupId);
  Future<Either<Failure, void>> inviteNewMembers(InviteNewMembersParams params);
  Future<Either<Failure, List<ReceivedGroupInviteEntity>>> getReceivedGroupInvite();
  Future<Either<Failure, void>> acceptGroupInvite(String id);
  Future<Either<Failure, void>> deleteGroupInvite(String id);
  Future<Either<Failure, List<ManagedGroupEntity>>> getManagedGroup();
  Future<Either<Failure, List<ManagedGroupEntity>>> getJoinedGroup();
}