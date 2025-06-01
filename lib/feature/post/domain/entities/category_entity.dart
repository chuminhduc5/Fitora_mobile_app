import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
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

  const CategoryEntity({
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

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        slug,
        followerCount,
        postCount,
        trendScore,
        // sortOrder,
        // createdAt,
        // updatedAt,
        // isDeleted,
        // createdBy,
        // lastModified,
        // lastModifiedBy,
        // parentId,
      ];
}
