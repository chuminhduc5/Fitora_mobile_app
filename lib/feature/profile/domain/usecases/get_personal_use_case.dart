import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';

class GetPersonalUseCase extends UseCase<ProfileEntity, String> {
  final ProfileRepositoryImpl _profileRepositoryImpl;

  GetPersonalUseCase(this._profileRepositoryImpl);

  @override
  Future<Either<Failure, ProfileEntity>> call(String params) async {
    return await _profileRepositoryImpl.getPersonal(params);
  }
}
