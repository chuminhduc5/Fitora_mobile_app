import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthSignInUseCase extends UseCase<AuthEntity, Params> {
  final AuthRepository _authRepository;

  AuthSignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthEntity>> call(Params params) async {
    if (!params.email.isEmailValid) {
      return Left(InvalidEmailFailure());
    }

    if (!params.password.isPasswordValid) {
      return Left(InvalidPasswordFailure());
    }

    final result = await _authRepository.signIn(params);
    logg.i("Kết quả nhận được: $result");
    return result;
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
