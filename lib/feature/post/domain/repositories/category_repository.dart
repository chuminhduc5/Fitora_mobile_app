import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/category_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

abstract class CategoryRepository {
  Future<Either<Failure, void>> createCategory(CreateCategoryParams params);
  Future<Either<Failure, CategoryEntity>> getCategoryById(String id);
  Future<Either<Failure, void>> followCategory(String id);
  Future<Either<Failure, void>> unfollowCategory(String id);
  Future<Either<Failure, List<CategoryEntity>>> getFollowed();
  Future<Either<Failure, List<CategoryEntity>>> getTrending();
}