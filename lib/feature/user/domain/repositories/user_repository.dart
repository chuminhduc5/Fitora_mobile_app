import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/usecase_params.dart';

abstract class UserRepository {
  Future<Either<Failure, UserProfileEntity>> getProfile();
  Future<Either<Failure, void>> updateProfile(UpdateProfileParams params);
  Future<Either<Failure, UserProfileEntity>> getPersonal(String userId);
  Future<Either<Failure, List<UserEntity>>> getUsers();
}