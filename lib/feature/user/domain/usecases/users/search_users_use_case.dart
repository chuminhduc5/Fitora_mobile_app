import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/user_repository.dart';

class SearchUsersUseCase extends UseCase<List<UserEntity>, String> {
  final UserRepository _userRepository;

  SearchUsersUseCase(this._userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(String params) async {
    return _userRepository.searchUsers(params);
  }
}
