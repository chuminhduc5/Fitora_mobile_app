import 'package:equatable/equatable.dart';

class GroupFormInputData extends Equatable {
  final String inputName;
  final String inputDescription;
  final int inputPrivacy;
  final bool inputRequirePostApproval;
  final String inputCoverImageUrl;
  final String inputAvatarUrl;

  const GroupFormInputData({
    required this.inputName,
    required this.inputDescription,
    required this.inputPrivacy,
    required this.inputRequirePostApproval,
    required this.inputCoverImageUrl,
    required this.inputAvatarUrl,
  });

  @override
  List<Object?> get props => [
        inputName,
        inputDescription,
        inputPrivacy,
        inputRequirePostApproval,
        inputCoverImageUrl,
        inputAvatarUrl,
      ];

  GroupFormInputData copyWith({
    String? inputName,
    String? inputDescription,
    int? inputPrivacy,
    bool? inputRequirePostApproval,
    String? inputCoverImageUrl,
    String? inputAvatarUrl,
  }) {
    return GroupFormInputData(
      inputName: inputName ?? this.inputName,
      inputDescription: inputDescription ?? this.inputDescription,
      inputPrivacy: inputPrivacy ?? this.inputPrivacy,
      inputRequirePostApproval: inputRequirePostApproval ?? this.inputRequirePostApproval,
      inputCoverImageUrl: inputCoverImageUrl ?? this.inputCoverImageUrl,
      inputAvatarUrl: inputAvatarUrl ?? this.inputAvatarUrl,
    );
  }
}
