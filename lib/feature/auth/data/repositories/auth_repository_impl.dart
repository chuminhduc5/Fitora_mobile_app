import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/common/helper/mapper/auth/auth_mapper.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/auth/data/models/request/sign_in_req_model.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_in_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_up_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

import '../models/request/sign_up_req_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  const AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> checkSignInStatus() {
    // TODO: implement checkSignInStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> signIn(SignInReqParams params) async {
    try {
      final model = SignInReqModel(
        email: params.email,
        password: params.password,
      );
      final result = await _authRemoteDataSource.signIn(model);
      final entity = AuthMapper.toEntity(result);
      return Right(entity);
    } catch (e, stacktrace) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signUp(SignUpReqParams params) async {
    try {
      final model = SignUpReqModel(
        email: params.email,
        password: params.password,
        fullName: params.username,
      );
      await _authRemoteDataSource.signUp(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
