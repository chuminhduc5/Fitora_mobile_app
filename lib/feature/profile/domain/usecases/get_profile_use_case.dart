import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';

class GetProfileUseCase extends UseCase<Either, NoParams> {
  @override
  Future<Either<Failure, Either>> call(NoParams params) async {
    throw UnimplementedError();
  }
}