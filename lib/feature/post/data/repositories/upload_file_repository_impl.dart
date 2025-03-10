import 'package:dartz/dartz.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/helper/mapper/post/upload_file_mapper.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/upload_file_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/upload_file_request.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/upload_file_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/upload_file_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';

class UploadFileRepositoryImpl implements UploadFileRepository {
  final UploadFileRemoteDataSource _uploadFileRemoteDataSource;

  const UploadFileRepositoryImpl(this._uploadFileRemoteDataSource);

  @override
  Future<Either<Failure, UploadFileEntity>> uploadFile(
      UploadFileParams params) async {
    try {
      final request = UploadFileRequest(url: params.url);
      final result = await _uploadFileRemoteDataSource.uploadFile(request);
      return Right(UploadFileMapper.toEntity(result));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
