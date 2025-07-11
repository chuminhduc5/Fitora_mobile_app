import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/upload_file_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

abstract class UploadFileRepository {
  Future<Either<Failure, UploadFileEntity>> uploadFile(File file);
}