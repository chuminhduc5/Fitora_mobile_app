import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/post/category_mapper.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/category_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/categories/create_category_request.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/category_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/category_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _categoryRemoteDataSource;

  const CategoryRepositoryImpl(this._categoryRemoteDataSource);

  @override
  Future<Either<Failure, void>> createCategory(CreateCategoryParams params) async {
    try {
      final result = await _categoryRemoteDataSource.createCategory(
        CreateCategoryRequest(
          name: params.name,
          slug: params.slug,
          description: params.description,
          parentId: params.parentId,
        ),
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(String id) async {
    try {
      final result = await _categoryRemoteDataSource.getCategoryById(id);
      return Right(CategoryMapper.toEntity(result));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> followCategory(String id) async {
    try {
     final result = await _categoryRemoteDataSource.followCategory(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unfollowCategory(String id) async {
    try {
      final result = await _categoryRemoteDataSource.unfollowCategory(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getFollowed() async {
    try {
      final result = await _categoryRemoteDataSource.getFollowed();
      final followed = result.map((i) => CategoryMapper.toEntity(i)).toList();
      return Right(followed);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getTrending() async {
    try {
      final result = await _categoryRemoteDataSource.getFollowed();
      final trending = result.map((i) => CategoryMapper.toEntity(i)).toList();
      return Right(trending);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
