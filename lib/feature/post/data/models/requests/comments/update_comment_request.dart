class UpdateCommentRequest {
  final String id;
  final String content;
  final String mediaUrl;

  const UpdateCommentRequest({
    required this.id,
    required this.content,
    required this.mediaUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "content": content,
      "mediaUrl": mediaUrl,
    };
  }
}
