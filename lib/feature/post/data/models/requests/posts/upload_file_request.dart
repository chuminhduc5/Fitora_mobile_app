import 'dart:io';

class UploadFileRequest {
  final File url;

  const UploadFileRequest({required this.url});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
    };
  }
}