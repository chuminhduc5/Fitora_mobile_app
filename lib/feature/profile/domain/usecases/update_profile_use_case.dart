import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';

class UpdateProfileUseCase extends UseCase<void, Params> {
  @override
  Future<Either<Failure, void>> call(Params params) async {
    throw UnimplementedError();
  }
}

class Params extends Equatable {
  @override
  List<Object?> get props => [];
}