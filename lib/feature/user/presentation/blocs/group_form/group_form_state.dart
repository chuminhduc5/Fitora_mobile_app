part of 'group_form_bloc.dart';

@immutable
abstract class GroupFormState extends Equatable {
  final GroupFormData data;

  const GroupFormState(this.data);

  @override
  List<Object?> get props => [data];
}

class GroupFormInitialState extends GroupFormState {
  const GroupFormInitialState()
      : super(
          const GroupFormData(
            name: "",
            description: "",
            privacy: 1,
            requirePostApproval: true,
            coverImageUrl: "",
            avatarUrl: "",
          ),
        );
}

class GroupFormDataState extends GroupFormState {
  final GroupFormInputData inputData;

  GroupFormDataState(this.inputData)
      : super(
          GroupFormData(
            name: inputData.inputName,
            description: inputData.inputDescription,
            privacy: inputData.inputPrivacy,
            requirePostApproval: inputData.inputRequirePostApproval,
            coverImageUrl: inputData.inputCoverImageUrl,
            avatarUrl: inputData.inputAvatarUrl,
          ),
        );
}
