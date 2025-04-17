class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isDeleted;
  final String? createdBy;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final String? parentId;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.sortOrder,
    required this.createdAt,
    this.updatedAt,
    required this.isDeleted,
    this.createdBy,
    this.lastModified,
    this.lastModifiedBy,
    this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      sortOrder: json['sortOrder'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      isDeleted: json['isDeleted'] ?? false,
      createdBy: json['createdBy'],
      lastModified: json['lastModified'] != null
          ? DateTime.tryParse(json['lastModified'])
          : null,
      lastModifiedBy: json['lastModifiedBy'],
      parentId: json['parentId'],
    );
  }
}
