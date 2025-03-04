import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/usecase_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, void>> updateProfile(UpdateProfileParams params);
}