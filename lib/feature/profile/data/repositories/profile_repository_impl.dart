import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/profile/profile_mapper.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/profile/data/models/requests/update_profile_request.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:fitora_mobile_app/feature/profile/domain/repositories/profile_repository.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/usecase_params.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  const ProfileRepositoryImpl(this._profileRemoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final result = await _profileRemoteDataSource.fetchProfile();
      logg.i("Thông tin người dùng chưa convert: ${result.email}");
      final profile = ProfileMapper.toEntity(result);
      logg.i("Thông tin người dùng(Repo): $profile");
      return Right(profile);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(UpdateProfileParams params) async {
    try {
      final model = UpdateProfileRequest(
        id: params.id,
        userId: params.userId,
        firstName: params.firstName,
        lastName: params.lastName,
        birthDate: params.birthDate,
        gender: params.gender,
        address: params.address,
        phoneNumber: params.phoneNumber,
        profilePictureUrl: params.profilePictureUrl,
        profileBackgroundPictureUrl: params.profileBackgroundPictureUrl,
        bio: params.bio,
      );
      final result = await _profileRemoteDataSource.updateProfile(model);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getPersonal(String userId) async {
    try {
      final result = await _profileRemoteDataSource.fetchPersonal(userId);
      final personal = ProfileMapper.toEntity(result);
      return Right(personal);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
