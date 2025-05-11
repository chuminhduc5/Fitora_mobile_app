import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/category_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/categories/create_category_request.dart';
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
}
