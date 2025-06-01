import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/upload_file_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/upload_file_repository.dart';

class UploadFileUseCase extends UseCase<UploadFileEntity, File> {
  final UploadFileRepository _uploadFileRepository;

  UploadFileUseCase(this._uploadFileRepository);

  @override
  Future<Either<Failure, UploadFileEntity>> call(File params) async {
    return await _uploadFileRepository.uploadFile(params);
  }

  // @override
  // Future<Either<Failure, UploadFileEntity>> call(Params params) async {
  //   return await _uploadFileRepository.uploadFile(params);
  // }
}

class Params extends Equatable {
  final File url;

  const Params({required this.url});

  @override
  List<Object?> get props => [url];
}
