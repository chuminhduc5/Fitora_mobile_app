import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/profile/profile_mapper.dart';
import 'package:fitora_mobile_app/feature/profile/data/datasources/profile_remote_data_source.dart';
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
      final profile = ProfileMapper.toEntity(result);
      return Right(profile);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(
      UpdateProfileParams params) async {
    throw UnimplementedError();
  }
}
