import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/user/user_mapper.dart';
import 'package:fitora_mobile_app/core/helper/mapper/user/user_profile_mapper.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/data/datasources/user_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/user/data/models/requests/profile/update_profile_request.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/user_repository.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/usecase_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  const UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Either<Failure, UserProfileEntity>> getProfile() async {
    try {
      final result = await _userRemoteDataSource.fetchProfile();
      logg.i("Thông tin người dùng chưa convert: ${result.email}");
      final profile = UserProfileMapper.toEntity(result);
      logg.i("Thông tin người dùng(Repo): $profile");
      // await _secureLocalStorage.save(key: "user_id", value: result.user.id);
      // logg.i("ID Người dùng: ${result.user.id}");
      // await _hiveLocalStorage.save(key: "user", value: result, boxName: "cache");
      // logg.i("Thông tin người dùng: $result");
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
      final result = await _userRemoteDataSource.updateProfile(model);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> getPersonal(String userId) async {
    try {
      final result = await _userRemoteDataSource.fetchPersonal(userId);
      final personal = UserProfileMapper.toEntity(result);
      return Right(personal);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final result = await _userRemoteDataSource.fetchUsers();
      final users = result.map((i) => UserMapper.toEntity(i)).toList();
      logg.i("Danh sách người dùng (Repository): $users");
      return Right(users);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> searchUsers(String keySearch) async {
    try {
      final result = await _userRemoteDataSource.searchUsers(keySearch);
      final users = result.map((i) => UserMapper.toEntity(i)).toList();
      logg.i("Danh sách người dùng (Repository): $users");
      return Right(users);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}