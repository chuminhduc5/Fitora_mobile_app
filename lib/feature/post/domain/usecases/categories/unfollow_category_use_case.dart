import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/category_repository.dart';

class UnfollowCategoryUseCase extends UseCase<void, String> {
  final CategoryRepository _categoryRepository;

  UnfollowCategoryUseCase(this._categoryRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _categoryRepository.unfollowCategory(params);
  }
}
