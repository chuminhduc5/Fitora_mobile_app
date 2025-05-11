import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/user_repository.dart';

class GetUsersUseCase extends UseCase<List<UserEntity>, NoParams> {
  final UserRepository _userRepository;
  GetUsersUseCase(this._userRepository);
  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await _userRepository.getUsers();
  }
}