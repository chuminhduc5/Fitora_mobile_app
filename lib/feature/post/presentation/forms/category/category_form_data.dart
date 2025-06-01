import 'package:equatable/equatable.dart';

class CategoryFormData extends Equatable {
  final String name;
  final String slug;
  final String description;
  final String? parentId;
  final bool isValid;

  const CategoryFormData({
    required this.name,
    required this.slug,
    required this.description,
    this.parentId,
    required this.isValid,
  });

  @override
  List<Object?> get props => [name, slug, description, parentId];

  CategoryFormData copyWith({
    String? name,
    String? slug,
    String? description,
    String? parentId,
    bool? isValid,
  }) {
    return CategoryFormData(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      isValid: isValid ?? this.isValid,
    );
  }
}