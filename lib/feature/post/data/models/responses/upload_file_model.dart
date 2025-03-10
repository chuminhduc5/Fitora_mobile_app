import 'package:fitora_mobile_app/feature/post/domain/entities/upload_file_entity.dart';

class UploadFileModel {
  final String url;

  const UploadFileModel({required this.url});

  factory UploadFileModel.fromJson(Map<String, dynamic> json) {
    return UploadFileModel(url: json['url']);
  }
}