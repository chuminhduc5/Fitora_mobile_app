class UploadFileRequest {
  final String url;

  const UploadFileRequest({required this.url});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
    };
  }
}