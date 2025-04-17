import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/usecase_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signIn(SignInParams params);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, AuthEntity>> signUp(SignUpParams params);
  Future<Either<Failure, AuthEntity>> checkSignInStatus();
}