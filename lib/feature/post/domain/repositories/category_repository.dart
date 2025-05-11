import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

abstract class CategoryRepository {
  Future<Either<Failure, void>> createCategory(CreateCategoryParams params);
}