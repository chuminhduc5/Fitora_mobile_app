part of 'comment_form_bloc.dart';

@immutable
abstract class CommentFormState extends Equatable {
  final CommentFormData data;

  const CommentFormState(this.data);

  @override
  List<Object?> get props => [data];
}

class CommentFormInitialState extends CommentFormState {
  const CommentFormInitialState()
      : super(
          const CommentFormData(
            postId: "",
            parentCommentId: null,
            content: "",
            mediaUrl: "",
          ),
        );
}

class CommentFormDataState extends CommentFormState {
  final CommentFormInputData inputData;

  CommentFormDataState(this.inputData)
      : super(
          CommentFormData(
            postId: inputData.inputPostId,
            parentCommentId: inputData.inputParentCommentId,
            content: inputData.inputContent,
            mediaUrl: inputData.inputMediaUrl,
          ),
        );
}
