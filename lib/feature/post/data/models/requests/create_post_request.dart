class CreatePostRequest {
  final String? content;
  final String? mediaUrl;
  final int? privacy;
  final String? groupId;

  const CreatePostRequest(
    this.content,
    this.mediaUrl,
    this.privacy,
    this.groupId,
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "content": content,
      "mediaUrl": mediaUrl,
      "privacy": privacy,
      "groupId": groupId,
    };
  }
}
