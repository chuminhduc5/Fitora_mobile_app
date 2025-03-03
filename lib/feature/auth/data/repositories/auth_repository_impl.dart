import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/cache/secure_local_storage.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:fitora_mobile_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/auth/data/models/requests/sign_in_request.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/usecase_params.dart';
import '../../../../core/helper/mapper/auth/auth_mapper.dart';
import '../models/requests/sign_up_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final SecureLocalStorage _secureLocalStorage;
  final HiveLocalStorage _hiveLocalStorage;

  const AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._secureLocalStorage,
    this._hiveLocalStorage,
  );

  @override
  Future<Either<Failure, AuthEntity>> checkSignInStatus() async {
    try {
      final result = await _authLocalDataSource.checkSignInStatus();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> signIn(SignInParams params) async {
    try {
      final model = SignInRequest(
        email: params.email,
        password: params.password,
      );
      final response = await _authRemoteDataSource.signIn(model);
      final result = AuthMapper.toEntity(response);
      
      await _secureLocalStorage.save(key: "user_id", value: result.user.id);
      await _hiveLocalStorage.save(key: "user", value: result, boxName: "cache");
      
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final result = await _authRemoteDataSource.signOut();

      await _secureLocalStorage.delete(key: "user_id");
      await _hiveLocalStorage.delete(key: "user", boxName: "cache");

      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signUp(SignUpParams params) async {
    try {
      final model = SignUpRequest(
        email: params.email,
        password: params.password,
        fullName: params.username,
      );
      final result = await _authRemoteDataSource.signUp(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
