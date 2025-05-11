import 'package:equatable/equatable.dart';

class CommentFormInputData extends Equatable {
  final String inputPostId;
  final String? inputParentCommentId;
  final String inputContent;
  final String? inputMediaUrl;

  const CommentFormInputData({
    required this.inputPostId,
    this.inputParentCommentId,
    required this.inputContent,
    this.inputMediaUrl,
  });

  @override
  List<Object?> get props => [
        inputPostId,
        inputParentCommentId,
        inputContent,
        inputMediaUrl,
      ];

  CommentFormInputData copyWith({
    String? inputPostId,
    String? inputParentCommentId,
    String? inputContent,
    String? inputMediaUrl,
  }) {
    return CommentFormInputData(
      inputPostId: inputPostId ?? this.inputPostId,
      inputParentCommentId: inputParentCommentId ?? this.inputParentCommentId,
      inputContent: inputContent ?? this.inputContent,
      inputMediaUrl: inputMediaUrl ?? this.inputMediaUrl,
    );
  }
}
