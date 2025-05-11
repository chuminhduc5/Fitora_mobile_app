import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/group/group_form_data.dart';
import 'package:fitora_mobile_app/feature/user/presentation/forms/group/group_form_input_data.dart';
import 'package:meta/meta.dart';

part 'group_form_event.dart';

part 'group_form_state.dart';

class GroupFormBloc extends Bloc<GroupFormEvent, GroupFormState> {
  GroupFormBloc() : super(const GroupFormInitialState()) {
    on<GroupLoadDataEvent>(_loadData);
    on<GroupNameChangeEvent>(_nameChanged);
    on<GroupDescriptionChangeEvent>(_descriptionChanged);
    on<GroupPrivacyChangeEvent>(_privacyChanged);
    on<GroupRequirePostApprovalChangeEvent>(_requirePostApprovalChanged);
    on<GroupCoverImageUrlChangeEvent>(_coverImageUrlChanged);
    on<GroupAvatarUrlChangeEvent>(_avatarUrlChanged);
  }

  Future _loadData(GroupLoadDataEvent event, Emitter emit) async {
    final updateData = GroupFormInputData(
      inputName: event.params.name,
      inputDescription: event.params.description,
      inputPrivacy: event.params.privacy,
      inputRequirePostApproval: event.params.requirePostApproval,
      inputCoverImageUrl: event.params.coverImageUrl,
      inputAvatarUrl: event.params.avatarUrl,
    );
    emit(GroupFormDataState(updateData));
  }

  Future _nameChanged(GroupNameChangeEvent event, Emitter emit) async {
    final updateData = GroupFormInputData(
      inputName: event.name,
      inputDescription: state.data.description,
      inputPrivacy: state.data.privacy,
      inputRequirePostApproval: state.data.requirePostApproval,
      inputCoverImageUrl: state.data.coverImageUrl,
      inputAvatarUrl: state.data.avatarUrl,
    );
    emit(GroupFormDataState(updateData));
  }

  Future _descriptionChanged(
      GroupDescriptionChangeEvent event, Emitter emit) async {
    final updateData = GroupFormInputData(
      inputName: state.data.name,
      inputDescription: event.description,
      inputPrivacy: state.data.privacy,
      inputRequirePostApproval: state.data.requirePostApproval,
      inputCoverImageUrl: state.data.coverImageUrl,
      inputAvatarUrl: state.data.avatarUrl,
    );
    emit(GroupFormDataState(updateData));
  }

  Future _privacyChanged(GroupPrivacyChangeEvent event, Emitter emit) async {
    final updateData = GroupFormInputData(
      inputName: state.data.name,
      inputDescription: state.data.description,
      inputPrivacy: event.privacy,
      inputRequirePostApproval: state.data.requirePostApproval,
      inputCoverImageUrl: state.data.coverImageUrl,
      inputAvatarUrl: state.data.avatarUrl,
    );
    emit(GroupFormDataState(updateData));
  }

  Future _requirePostApprovalChanged(
      GroupRequirePostApprovalChangeEvent event, Emitter emit) async {
    final updateData = GroupFormInputData(
      inputName: state.data.name,
      inputDescription: state.data.description,
      inputPrivacy: state.data.privacy,
      inputRequirePostApproval: event.requirePostApproval,
      inputCoverImageUrl: state.data.coverImageUrl,
      inputAvatarUrl: state.data.avatarUrl,
    );
    emit(GroupFormDataState(updateData));
  }

  Future _coverImageUrlChanged(
      GroupCoverImageUrlChangeEvent event, Emitter emit) async {
    final updateData = GroupFormInputData(
      inputName: state.data.name,
      inputDescription: state.data.description,
      inputPrivacy: state.data.privacy,
      inputRequirePostApproval: state.data.requirePostApproval,
      inputCoverImageUrl: event.coverImageUrl,
      inputAvatarUrl: state.data.avatarUrl,
    );
    emit(GroupFormDataState(updateData));
  }

  Future _avatarUrlChanged(
      GroupAvatarUrlChangeEvent event, Emitter emit) async {
    final updateData = GroupFormInputData(
      inputName: state.data.name,
      inputDescription: state.data.description,
      inputPrivacy: state.data.privacy,
      inputRequirePostApproval: state.data.requirePostApproval,
      inputCoverImageUrl: state.data.coverImageUrl,
      inputAvatarUrl: event.avatarUrl,
    );
    emit(GroupFormDataState(updateData));
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE GroupFormBloc =====");
    return super.close();
  }
}
