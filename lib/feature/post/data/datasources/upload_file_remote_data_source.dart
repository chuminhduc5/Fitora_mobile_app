import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/data/models/responses/upload_file_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

abstract class UploadFileRemoteDataSource {
  Future<UploadFileModel> uploadFile(File file);
}

class UploadFileRemoteDataSourceImpl implements UploadFileRemoteDataSource {
  final DioClient _dioClient;

  const UploadFileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UploadFileModel> uploadFile(File file) async {
    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        contentType: MediaType.parse(mimeType),
        filename: file.path.split('/').last,
      )
    });

    try {
      final response = await _dioClient.post(
        ApiUrl.uploadFile,
        data: formData,
      );
      return UploadFileModel.fromJson(response.data);
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
