import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthCheckSignInStatusUseCase extends UseCase<AuthEntity, NoParams> {
  final AuthRepository _authRepository;

  AuthCheckSignInStatusUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthEntity>> call(NoParams params) async {
    return await _authRepository.checkSignInStatus();
  }
}
