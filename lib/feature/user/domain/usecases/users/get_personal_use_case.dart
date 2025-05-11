import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/user_repository.dart';

class GetPersonalUseCase extends UseCase<UserProfileEntity, String> {
  final UserRepository _userRepository;

  GetPersonalUseCase(this._userRepository);

  @override
  Future<Either<Failure, UserProfileEntity>> call(String params) async {
    return await _userRepository.getPersonal(params);
  }
}
