import 'package:fitora_mobile_app/feature/post/data/models/responses/upload_file_model.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/upload_file_entity.dart';

class UploadFileMapper {
  static UploadFileEntity toEntity(UploadFileModel file) {
    return UploadFileEntity(url: file.url);
  }
}