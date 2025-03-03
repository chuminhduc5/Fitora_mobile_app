import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/personal_entity.dart';

abstract class PersonalRepository {
  Future<Either<Failure, PersonalEntity>> getPersonal();
}