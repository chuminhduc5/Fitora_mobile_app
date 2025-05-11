class VotePostRequest {
  final String userId;
  final String postId;
  final int voteType;

  const VotePostRequest({
    required this.userId,
    required this.postId,
    required this.voteType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "userId": userId,
      "postId": postId,
      "voteType": voteType,
    };
  }
}
