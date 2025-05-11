class VoteCommentRequest {
  final String userId;
  final String commentId;
  final int voteType;

  const VoteCommentRequest({
    required this.userId,
    required this.commentId,
    required this.voteType,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "userId": userId,
      "commentId": commentId,
      "voteType": voteType,
    };
  }
}
