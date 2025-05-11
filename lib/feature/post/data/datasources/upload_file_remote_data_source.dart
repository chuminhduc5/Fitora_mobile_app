import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/post/data/models/requests/posts/upload_file_request.dart';
import 'package:fitora_mobile_app/feature/post/data/models/responses/upload_file_model.dart';

abstract class UploadFileRemoteDataSource {
  Future<UploadFileModel> uploadFile(UploadFileRequest request);
}

class UploadFileRemoteDataSourceImpl implements UploadFileRemoteDataSource {
  final DioClient _dioClient;

  const UploadFileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UploadFileModel> uploadFile(UploadFileRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiUrl.uploadFile,
        data: request.toJson(),
      );
      return UploadFileModel.fromJson(response.data);
    } on DioException catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
