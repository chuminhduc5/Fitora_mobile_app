class CreateCategoryFormData {
  final String name;
  final String slug;
  final String description;
  final String? parentId;

  const CreateCategoryFormData({
    required this.name,
    required this.slug,
    required this.description,
    this.parentId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'slug': slug,
      'description': description,
      'parentId': parentId,
    };
  }
}
