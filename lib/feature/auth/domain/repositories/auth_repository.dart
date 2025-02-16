import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_in_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_up_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn(SignInReqParams params);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, void>> signUp(SignUpReqParams params);
  Future<Either<Failure, UserEntity>> checkSignInStatus();
}