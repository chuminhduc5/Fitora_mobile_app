import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_up_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthSignUpUseCase extends UseCase<void, SignUpReqParams> {
  final AuthRepository _authRepository;

  AuthSignUpUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(SignUpReqParams params) async {
    if (!params.email.isEmailValid) {
      return Left(InvalidEmailFailure());
    }

    if (!params.password.isPasswordValid) {
      return Left(InvalidPasswordFailure());
    }

    if (params.password != params.confirmPassword) {
      return Left(PasswordNotMatchFailure());
    }

    final result = await _authRepository.signUp(params);
    return result;
  }
}
