import 'package:equatable/equatable.dart';

class CategoryFormInputData extends Equatable {
  final String inputName;
  final String inputSlug;
  final String inputDescription;
  final String? inputParentId;
  final bool inputIsValid;

  const CategoryFormInputData({
    required this.inputName,
    required this.inputSlug,
    required this.inputDescription,
    this.inputParentId,
    required this.inputIsValid,
  });

  @override
  List<Object?> get props => [
    inputName,
    inputSlug,
    inputDescription,
    inputParentId,
    inputIsValid,
  ];

  CategoryFormInputData copyWith({
    String? inputName,
    String? inputSlug,
    String? inputDescription,
    String? inputParentId,
    bool? inputIsValid,
  }) {
    return CategoryFormInputData(
      inputName: inputName ?? this.inputName,
      inputSlug: inputSlug ?? this.inputSlug,
      inputDescription: inputDescription ?? this.inputDescription,
      inputParentId: inputParentId ?? this.inputParentId,
      inputIsValid: inputIsValid ?? this.inputIsValid,
    );
  }
}
