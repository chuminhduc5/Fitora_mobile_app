class InteractPostFormData {
  final String userId;
  final String postId;
  final int voteType;

  const InteractPostFormData({
    required this.userId,
    required this.postId,
    required this.voteType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'postId': postId,
      'voteType': voteType,
    };
  }
}
