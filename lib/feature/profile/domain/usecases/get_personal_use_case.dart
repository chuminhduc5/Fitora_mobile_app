import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/personal_entity.dart';
import 'package:fitora_mobile_app/feature/profile/domain/repositories/personal_repository.dart';

class GetPersonalUseCase extends UseCase<PersonalEntity, NoParams> {
  final PersonalRepository _personalRepository;

  GetPersonalUseCase(this._personalRepository);

  @override
  Future<Either<Failure, PersonalEntity>> call(NoParams params) async {
    return await _personalRepository.getPersonal();
  }
}
