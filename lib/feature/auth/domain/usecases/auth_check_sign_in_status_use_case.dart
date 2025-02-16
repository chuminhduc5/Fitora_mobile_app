import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/user_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthCheckSignInStatusUseCase extends UseCase<UserEntity, NoParams> {
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await sl<AuthRepository>().checkSignInStatus();
  }
}