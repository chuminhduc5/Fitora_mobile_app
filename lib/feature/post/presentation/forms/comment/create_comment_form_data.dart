class CreateCommentFormData {
  final String postId;
  final String? parentCommentId;
  final String content;
  final String mediaUrl;

  const CreateCommentFormData({
    required this.postId,
    this.parentCommentId,
    required this.content,
    required this.mediaUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "postId": postId,
      "parentCommentId": parentCommentId,
      "content": content,
      "mediaUrl": mediaUrl,
    };
  }
}
