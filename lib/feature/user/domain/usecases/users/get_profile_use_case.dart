import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/user_repository.dart';

class GetProfileUseCase extends UseCase<UserProfileEntity, NoParams> {
  final UserRepository _userRepository;
  GetProfileUseCase(this._userRepository);
  @override
  Future<Either<Failure, UserProfileEntity>> call(NoParams params) async {
    return await _userRepository.getProfile();
  }
}