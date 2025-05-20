class SavePostRequest {
  final String userId;
  final String postId;

  const SavePostRequest({
    required this.userId,
    required this.postId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      "userId": userId,
      "postId": postId,
    };
  }
}