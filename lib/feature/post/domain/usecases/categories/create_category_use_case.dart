import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/category_repository.dart';

class CreateCategoryUseCase extends UseCase<void, Params> {
  final CategoryRepository _categoryRepository;

  CreateCategoryUseCase(this._categoryRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _categoryRepository.createCategory(params);
  }
}

class Params extends Equatable {
  final String name;
  final String slug;
  final String description;
  final String parentId;

  const Params({
    required this.name,
    required this.slug,
    required this.description,
    required this.parentId,
  });

  @override
  List<Object?> get props => [name, slug, description, parentId];
}
