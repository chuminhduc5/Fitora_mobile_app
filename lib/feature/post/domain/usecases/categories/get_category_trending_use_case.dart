import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/category_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/category_repository.dart';

class GetCategoryTrendingUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  final CategoryRepository _categoryRepository;

  GetCategoryTrendingUseCase(this._categoryRepository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await _categoryRepository.getTrending();
  }
}