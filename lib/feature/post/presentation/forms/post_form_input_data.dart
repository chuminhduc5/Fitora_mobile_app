import 'package:equatable/equatable.dart';

class PostFormInputData extends Equatable {
  final String inputContent;
  final String inputMediaUrl;
  final int inputPrivacy;
  final String? inputGroupId;
  final String? inputCategoryId;
  final bool inputIsValid;

  const PostFormInputData({
    required this.inputContent,
    required this.inputMediaUrl,
    required this.inputPrivacy,
    this.inputGroupId,
    this.inputCategoryId,
    required this.inputIsValid,
  });

  @override
  List<Object?> get props => [
        inputContent,
        inputMediaUrl,
        inputPrivacy,
        inputGroupId,
        inputCategoryId,
        inputIsValid,
      ];

  PostFormInputData copyWith({
    String? inputContent,
    String? inputMediaUrl,
    int? inputPrivacy,
    String? inputGroupId,
    String? inputCategoryId,
    bool? inputIsValid,
  }) {
    return PostFormInputData(
      inputContent: inputContent ?? this.inputContent,
      inputMediaUrl: inputMediaUrl ?? this.inputMediaUrl,
      inputPrivacy: inputPrivacy ?? this.inputPrivacy,
      inputGroupId: inputGroupId ?? this.inputGroupId,
      inputCategoryId: inputCategoryId ?? this.inputCategoryId,
      inputIsValid: inputIsValid ?? this.inputIsValid,
    );
  }
}
