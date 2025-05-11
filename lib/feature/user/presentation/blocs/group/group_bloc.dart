import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_member_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/managed_group_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/received_group_invite_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/accept_group_invite_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/create_group_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_group_by_id_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_group_member_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_managed_group_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_received_group_invite_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/invite_new_members_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/group/create_group_form_data.dart';
import 'package:meta/meta.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final CreateGroupUseCase _createGroupUseCase;
  final GetGroupByIdUseCase _getGroupByIdUseCase;
  final GetGroupMemberUseCase _getGroupMemberUseCase;
  final InviteNewMembersUseCase _inviteNewMembersUseCase;
  final GetReceivedGroupInviteUseCase _getReceivedGroupInviteUseCase;
  final AcceptGroupInviteUseCase _acceptGroupInviteUseCase;
  final GetManagedGroupUseCase _getManagedGroupUseCase;

  GroupBloc(
    this._createGroupUseCase,
    this._getGroupByIdUseCase,
    this._getGroupMemberUseCase,
    this._inviteNewMembersUseCase,
    this._getReceivedGroupInviteUseCase,
    this._acceptGroupInviteUseCase,
    this._getManagedGroupUseCase,
  ) : super(GroupInitialState()) {
    on<CreateGroupEvent>(_create);
    on<FetchGroupByIdEvent>(_fetchGroupById);
    on<FetchGroupMemberEvent>(_fetchGroupMember);
    on<InviteNewMembersEvent>(_inviteNewMember);
    on<FetchReceivedGroupInviteEvent>(_fetchReceived);
    on<AcceptGroupInviteEvent>(_accept);
    on<FetchManagedGroupEvent>(_fetchManagedGroup);
  }

  Future<void> _create(CreateGroupEvent event, Emitter emit) async {
    emit(CreateGroupLoadingState());

    final result = await _createGroupUseCase.call(CreateGroupParams(
      name: event.params.name,
      description: event.params.description,
      privacy: event.params.privacy,
      requirePostApproval: event.params.requirePostApproval,
      coverImageUrl: event.params.coverImageUrl,
      avatarUrl: event.params.avatarUrl,
    ));

    result.fold(
      (failure) => emit(CreateGroupFailureState(mapFailureToMessage(failure))),
      (success) => emit(CreateGroupSuccessState(data: success)),
    );
  }

  Future<void> _fetchGroupById(FetchGroupByIdEvent event, Emitter emit) async {
    emit(FetchGroupByIdLoadingState());

    final result = await _getGroupByIdUseCase.call(event.id);

    result.fold(
      (failure) => emit(FetchGroupByIdFailureState(mapFailureToMessage(failure))),
      (success) => emit(FetchGroupByIdSuccessState(data: success)),
    );
  }

  Future<void> _fetchGroupMember(FetchGroupMemberEvent event, Emitter emit) async {
    emit(FetchGroupMemberLoadingState());

    final result = await _getGroupMemberUseCase.call(event.groupId);

    result.fold(
      (failure) => emit(FetchGroupMemberFailureState(mapFailureToMessage(failure))),
      (success) => emit(FetchGroupMemberSuccessState(data: success)),
    );
  }

  Future<void> _inviteNewMember(InviteNewMembersEvent event, Emitter emit) async {
    emit(InviteNewMembersLoadingState());

    final result = await _inviteNewMembersUseCase.call(InviteNewMembersParams(
      groupId: event.groupId,
      receiverUserIds: event.receiverUserIds,
    ));

    result.fold(
      (failure) => emit(InviteNewMembersFailureState(mapFailureToMessage(failure))),
      (success) => emit(InviteNewMembersSuccessState()),
    );
  }

  Future<void> _fetchReceived(FetchReceivedGroupInviteEvent event, Emitter emit) async {
    emit(FetchReceivedGroupInviteLoadingState());

    final result = await _getReceivedGroupInviteUseCase.call(NoParams());

    result.fold(
      (failure) => emit(FetchReceivedGroupInviteFailureState(mapFailureToMessage(failure))),
      (success) => emit(FetchReceivedGroupInviteSuccessState(data: success)),
    );
  }

  Future<void> _accept(AcceptGroupInviteEvent event, Emitter emit) async {
    emit(AcceptGroupInviteLoadingState());

    final result = await _acceptGroupInviteUseCase.call(event.id);

    result.fold(
      (failure) => emit(AcceptGroupInviteFailureState(mapFailureToMessage(failure))),
      (success) => emit(AcceptGroupInviteSuccessState()),
    );
  }

  Future<void> _fetchManagedGroup(FetchManagedGroupEvent event, Emitter emit) async {
    emit(FetchManagedGroupLoadingState());

    final result = await _getManagedGroupUseCase.call(NoParams());

    result.fold(
      (failure) => emit(FetchManagedGroupFailureState(mapFailureToMessage(failure))),
      (success) => emit(FetchManagedGroupSuccessState(data: success)),
    );
  }

  // @override
  // Future<void> close() {
  //   logger.i("===== CLOSE GroupBloc =====");
  //   return super.close();
  // }
}
