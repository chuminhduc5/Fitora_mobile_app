import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthSignUpUseCase extends UseCase<AuthEntity, Params> {
  final AuthRepository _authRepository;

  AuthSignUpUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthEntity>> call(Params params) async {
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
    logg.i("Kết quả nhận được: $result");
    return result;
  }
}

class Params extends Equatable {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const Params({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        confirmPassword,
      ];
}
