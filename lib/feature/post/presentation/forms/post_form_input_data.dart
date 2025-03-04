import 'package:equatable/equatable.dart';

class PostFormInputData extends Equatable {
  final String inputContent;
  final String inputMediaUrl;
  final int inputPrivacy;
  final String inputGroupId;
  final bool inputIsValid;

  const PostFormInputData(
      {required this.inputContent,
      required this.inputMediaUrl,
      required this.inputPrivacy,
      required this.inputGroupId,
      required this.inputIsValid});

  @override
  List<Object?> get props => [
        inputContent,
        inputMediaUrl,
        inputPrivacy,
        inputGroupId,
        inputIsValid,
      ];

  PostFormInputData copyWith({
    String? inputContent,
    String? inputMediaUrl,
    int? inputPrivacy,
    String? inputGroupId,
    bool? inputIsValid,
  }) {
    return PostFormInputData(
      inputContent: inputContent ?? this.inputContent,
      inputMediaUrl: inputMediaUrl ?? this.inputMediaUrl,
      inputPrivacy: inputPrivacy ?? this.inputPrivacy,
      inputGroupId: inputGroupId ?? this.inputGroupId,
      inputIsValid: inputIsValid ?? this.inputIsValid,
    );
  }
}
