import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';

class GetProfileUseCase extends UseCase<Either, ProfileEntity> {
  @override
  Future<Either<Failure, Either>> call(ProfileEntity params) {
    throw UnimplementedError();
  }
}