import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/auth/domain/repositories/auth_repository.dart';

class AuthSignOutUseCase extends UseCase<void, NoParams> {
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await sl<AuthRepository>().signOut();
  }
}