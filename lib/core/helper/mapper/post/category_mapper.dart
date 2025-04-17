import 'package:fitora_mobile_app/feature/post/data/models/responses/categoty_model.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/category_entity.dart';

class CategoryMapper {
  static CategoryEntity toEntity(CategoryModel category) {
    return CategoryEntity(
      id: category.id,
      name: category.name,
      slug: category.slug,
      description: category.description,
      sortOrder: category.sortOrder,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
      isDeleted: category.isDeleted,
      createdBy: category.createdBy,
      lastModified: category.lastModified,
      lastModifiedBy: category.lastModifiedBy,
      parentId: category.parentId,
    );
  }
}
