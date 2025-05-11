class UpdatePostRequest {
  final String id;
  final String content;
  final String mediaUrl;
  final int privacy;

  const UpdatePostRequest({
    required this.id,
    required this.content,
    required this.mediaUrl,
    required this.privacy,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "content": content,
      "mediaUrl": mediaUrl,
      "privacy": privacy,
    };
  }
}
