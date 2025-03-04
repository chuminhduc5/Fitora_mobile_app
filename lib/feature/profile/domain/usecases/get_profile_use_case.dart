import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:fitora_mobile_app/feature/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository _profileRepository;
  GetProfileUseCase(this._profileRepository);
  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) async {
    return await _profileRepository.getProfile();
  }
}