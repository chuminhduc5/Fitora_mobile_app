class CreatePostRequest {
  final String? content;
  final String? mediaUrl;
  final int? privacy;
  final String? groupId;

  const CreatePostRequest({
    required this.content,
    required this.mediaUrl,
    required this.privacy,
    required this.groupId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "content": content,
      "mediaUrl": mediaUrl,
      "privacy": privacy,
      "groupId": groupId,
    };
  }
}
