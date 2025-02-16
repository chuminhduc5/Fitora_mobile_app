import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_in_req_params.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/user_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthSignInUseCase extends UseCase<UserEntity, SignInReqParams> {
  @override
  Future<Either<Failure, UserEntity>> call(SignInReqParams params) async {
    if (!params.email.isEmailValid) {
      return const Left(InvalidEmailFailure(message: 'Email không đúng'));
    }

    if (!params.password.isPasswordValid) {
      return const Left(InvalidPasswordFailure(message: 'Mật khẩu không đúng'));
    }

    final result = await sl<AuthRepository>().signIn(params);
    return result;
  }
}
