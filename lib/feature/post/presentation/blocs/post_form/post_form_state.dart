part of 'post_form_bloc.dart';

@immutable
abstract class PostFormState extends Equatable {
  final PostFormData data;

  const PostFormState(this.data);

  @override
  List<Object?> get props => [data];
}

class PostFormInitialState extends PostFormState {
  const PostFormInitialState()
      : super(
          const PostFormData(
            content: "",
            mediaUrl: "",
            privacy: 0,
            groupId: null,
            categoryId: null,
            isValid: false,
          ),
        );
}

class PostFormDataState extends PostFormState {
  final PostFormInputData inputData;

  PostFormDataState(this.inputData)
      : super(
          PostFormData(
            content: inputData.inputContent,
            mediaUrl: inputData.inputMediaUrl,
            privacy: inputData.inputPrivacy,
            groupId: inputData.inputGroupId,
            categoryId: inputData.inputCategoryId,
            isValid: inputData.inputIsValid,
          ),
        );

  @override
  List<Object?> get props => [inputData];
}
