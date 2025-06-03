import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/data/models/requests/group/create_group_request.dart';
import 'package:fitora_mobile_app/feature/user/data/models/requests/group/invite_new_members_request.dart';
import 'package:fitora_mobile_app/feature/user/data/models/requests/group/update_group_request.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/group_member_model.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/group_model.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/managed_group_model.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/received_group_invite_model.dart';

abstract class GroupRemoteDataSource {
  Future<GroupMemberModel> createGroup(CreateGroupRequest request);
  Future<void> updateGroup(UpdateGroupRequest request);
  Future<void> deleteGroup(String groupId);
  Future<GroupResponseModel> fetchGroupById(String id);
  Future<List<GroupMemberModel>> fetchGroupMembers(String groupId);
  Future<void> inviteNewMembers(InviteNewMembersRequest request);
  Future<List<ReceivedGroupInviteModel>> fetchReceivedGroupInvite();
  Future<void> acceptGroupInvite(String id);
  Future<void> deleteGroupInvite(String id);
  Future<List<ManagedGroupModel>> fetchManagedGroup();
  Future<List<ManagedGroupModel>> fetchJoinedGroup();
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final DioClient _dioClient;

  const GroupRemoteDataSourceImpl(this._dioClient);

  @override
  Future<GroupMemberModel> createGroup(CreateGroupRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiUrl.createGroup,
        data: request.toJson(),
      );
      final group = response.data['data'] as Map<String, dynamic>;
      return GroupMemberModel.fromJson(group);
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    try {
      await _dioClient.delete('${ApiUrl.deleteGroup}?id=$groupId');
    } on DioException catch(e) {
      logger.e("Failed to load data: $e");
      throw ServerException();
    }
  }

  @override
  Future<GroupResponseModel> fetchGroupById(String id) async {
    try {
      final response = await _dioClient.get('${ApiUrl.getGroupById}?id=$id');
      return GroupResponseModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> updateGroup(UpdateGroupRequest request) async {
    try {
      await _dioClient.put(
        ApiUrl.updateGroup,
        data: request.toJson(),
      );
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> acceptGroupInvite(String id) async {
    try {
      await _dioClient.post('${ApiUrl.acceptGroupInvite}?Id=$id');
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteGroupInvite(String id) async {
    try {
      await _dioClient.post('${ApiUrl.deleteGroupInvite}?Id=$id');
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<GroupMemberModel>> fetchGroupMembers(String groupId) async {
    try {
      final response = await _dioClient.get('${ApiUrl.getGroupMember}?GroupId=$groupId');
      final data = response.data['data'];
      final List<GroupMemberModel> members = data.map((json) => GroupMemberModel.fromJson(json));
      logg.i("Group Members: $members");
      return members;
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<ReceivedGroupInviteModel>> fetchReceivedGroupInvite() async {
    try {
      final response = await _dioClient.get(ApiUrl.getReceivedGroupInvite);
      final data = response.data['data'];
      if (data != null && data['data'] is List) {
        final List<ReceivedGroupInviteModel> received = (data['data'] as List).map((json) => ReceivedGroupInviteModel.fromJson(json)).toList();
        logg.i("ReceivedGroupInviteModel: $received");
        return received;
      } else {
        throw Exception("Invalid response format");
      }
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> inviteNewMembers(InviteNewMembersRequest request) async {
    try {
      await _dioClient.post(ApiUrl.inviteNewMembers, data: request.toJson());
      print("🔍 Sending data: ${request.toJson()}");
    } on DioException catch(e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<ManagedGroupModel>> fetchManagedGroup() async {
    try {
      final response = await _dioClient.get(ApiUrl.getManagedGroup);
      final data = response.data['data'] as List<dynamic>;
      final List<ManagedGroupModel> managedGroup = data
          .map((i) => ManagedGroupModel.fromJson(i as Map<String, dynamic>))
          .toList();
      return managedGroup;
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<List<ManagedGroupModel>> fetchJoinedGroup() async {
    try {
      final response = await _dioClient.get(ApiUrl.getJoinedGroup);
      final data = response.data['data'] as List<dynamic>;
      final List<ManagedGroupModel> managedGroup = data
          .map((i) => ManagedGroupModel.fromJson(i as Map<String, dynamic>))
          .toList();
      return managedGroup;
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
