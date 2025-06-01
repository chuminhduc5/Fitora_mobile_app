part of 'category_form_bloc.dart';

@immutable
abstract class CategoryFormState extends Equatable {
  final CategoryFormData data;

  const CategoryFormState(this.data);

  @override
  List<Object?> get props => [data];
}

class CategoryFormInitialState extends CategoryFormState {
  const CategoryFormInitialState()
      : super(
          const CategoryFormData(
            name: "",
            slug: "",
            description: "",
            parentId: null,
            isValid: false,
          ),
        );
}

class CategoryFormDataState extends CategoryFormState {
  final CategoryFormInputData inputData;

  CategoryFormDataState(this.inputData)
      : super(
          CategoryFormData(
            name: inputData.inputName,
            slug: inputData.inputSlug,
            description: inputData.inputDescription,
            parentId: inputData.inputParentId,
            isValid: inputData.inputIsValid,
          ),
        );

  @override
  List<Object?> get props => [inputData];
}
