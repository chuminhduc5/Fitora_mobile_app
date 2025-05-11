import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/user/group_mapper.dart';
import 'package:fitora_mobile_app/core/helper/mapper/user/group_member_mapper.dart';
import 'package:fitora_mobile_app/core/helper/mapper/user/managed_group_mapper.dart';
import 'package:fitora_mobile_app/core/helper/mapper/user/received_group_invite_mapper.dart';
import 'package:fitora_mobile_app/feature/user/data/datasources/group_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/user/data/models/requests/group/create_group_request.dart';
import 'package:fitora_mobile_app/feature/user/data/models/requests/group/invite_new_members_request.dart';
import 'package:fitora_mobile_app/feature/user/data/models/requests/group/update_group_request.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_member_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/managed_group_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/received_group_invite_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/usecase_params.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource _groupRemoteDataSource;

  const GroupRepositoryImpl(this._groupRemoteDataSource);

  @override
  Future<Either<Failure, GroupMemberEntity>> createGroup(
      CreateGroupParams params) async {
    try {
      final model = CreateGroupRequest(
        name: params.name,
        description: params.description,
        privacy: params.privacy,
        requirePostApproval: params.requirePostApproval,
        coverImageUrl: params.coverImageUrl,
        avatarUrl: params.avatarUrl,
      );
      final result = await _groupRemoteDataSource.createGroup(model);
      final group = GroupMemberMapper.toEntity(result);
      return Right(group);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroup(CreateGroupParams params) async {
    // TODO: implement deleteGroup
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, GroupResponseEntity>> getGroupById(String id) async {
    try {
      final result = await _groupRemoteDataSource.fetchGroupById(id);
      final group = GroupMapper.toEntity(result);
      return Right(group);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupMemberEntity>> updateGroup(
      UpdateGroupParams params) async {
    try {
      final model = UpdateGroupRequest(
        id: params.id,
        name: params.name,
        description: params.description,
        privacy: params.privacy,
        requirePostApproval: params.requirePostApproval,
        coverImageUrl: params.coverImageUrl,
        avatarUrl: params.avatarUrl,
      );
      final result = await _groupRemoteDataSource.updateGroup(model);
      final group = GroupMemberMapper.toEntity(result);
      return Right(group);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> acceptGroupInvite(String id) async {
    try {
      final result = await _groupRemoteDataSource.acceptGroupInvite(id);
      return Right(result);
    } on DioException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupMemberEntity>>> getGroupMembers(String groupId) async {
    try {
      final result = await _groupRemoteDataSource.fetchGroupMembers(groupId);
      final members = result.map((i) => GroupMemberMapper.toEntity(i)).toList();
      return Right(members);
    } on DioException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ReceivedGroupInviteEntity>>> getReceivedGroupInvite() async {
    try {
      final result = await _groupRemoteDataSource.fetchReceivedGroupInvite();
      final members = result.map((i) => ReceivedGroupInviteMapper.toEntity(i)).toList();
      return Right(members);
    } on DioException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> inviteNewMembers(InviteNewMembersParams params) async {
    try {
      final request = InviteNewMembersRequest(
        groupId: params.groupId,
        receiverUserIds: params.receiverUserIds,
      );
      final result = await _groupRemoteDataSource.inviteNewMembers(request);
      return Right(result);
    } on DioException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ManagedGroupEntity>>> getManagedGroup() async {
    try {
      final result = await _groupRemoteDataSource.fetchManagedGroup();
      final members = result.map((i) => ManagedGroupMapper.toEntity(i)).toList();
      return Right(members);
    } on DioException {
      return Left(ServerFailure());
    }
  }
}
