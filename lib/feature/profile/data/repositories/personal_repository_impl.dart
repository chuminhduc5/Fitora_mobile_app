import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/profile/personal_mapper.dart';
import 'package:fitora_mobile_app/feature/profile/data/datasources/personal_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/personal_entity.dart';
import 'package:fitora_mobile_app/feature/profile/domain/repositories/personal_repository.dart';

class PersonalRepositoryImpl implements PersonalRepository {
  final PersonalRemoteDataSource _personalRemoteDataSource;

  const PersonalRepositoryImpl(this._personalRemoteDataSource);

  @override
  Future<Either<Failure, PersonalEntity>> getPersonal() async {
    try {
      final data = await _personalRemoteDataSource.getPersonal();
      var personal = PersonalMapper.toEntity(data);
      return Right(personal);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
