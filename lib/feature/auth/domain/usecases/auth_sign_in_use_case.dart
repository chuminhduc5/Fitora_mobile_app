import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_in_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthSignInUseCase extends UseCase<AuthEntity, SignInReqParams> {
  final AuthRepository _authRepository;

  AuthSignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthEntity>> call(SignInReqParams params) async {
    if (!params.email.isEmailValid) {
      return const Left(InvalidEmailFailure(message: 'Email không đúng'));
    }

    if (!params.password.isPasswordValid) {
      print("--------------${params.toString()}-----------------------");
      print("--------------${params.password}-----------------------");
      print("Password Valid: ${params.password.isPasswordValid}");
      return const Left(InvalidPasswordFailure(message: 'Mật khẩu không đúng'));
    }

    final result = await _authRepository.signIn(params);
    return result;
  }
}
