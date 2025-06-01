class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String slug;
  final int followerCount;
  final int postCount;
  final int trendScore;
  // final int sortOrder;
  // final DateTime createdAt;
  // final DateTime? updatedAt;
  // final bool isDeleted;
  // final String? createdBy;
  // final DateTime? lastModified;
  // final String? lastModifiedBy;
  // final String? parentId;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.followerCount,
    required this.postCount,
    required this.trendScore,
    // required this.sortOrder,
    // required this.createdAt,
    // this.updatedAt,
    // required this.isDeleted,
    // this.createdBy,
    // this.lastModified,
    // this.lastModifiedBy,
    // this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      slug: json['slug'] ?? '',
      followerCount: json['followerCount'] ?? 0,
      postCount: json['postCount'] ?? 0,
      trendScore: json['trendScore'] ?? 0,
      // sortOrder: json['sortOrder'] ?? 0,
      // createdAt: DateTime.parse(json['createdAt']),
      // updatedAt: json['updatedAt'] != null
      //     ? DateTime.tryParse(json['updatedAt'])
      //     : null,
      // isDeleted: json['isDeleted'] ?? false,
      // createdBy: json['createdBy'],
      // lastModified: json['lastModified'] != null
      //     ? DateTime.tryParse(json['lastModified'])
      //     : null,
      // lastModifiedBy: json['lastModifiedBy'],
      // parentId: json['parentId'],
    );
  }
}
