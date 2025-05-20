// class CommentModel {
//   final String userId;
//   final String postId;
//   final String? post;
//   final String? parentCommentId;
//   final String? parentComment;
//   final String content;
//   final String mediaUrl;
//   final int voteCount;
//   final List<String> commentVotes;
//   final int replyCount;
//   final bool isDeleted;
//   final String id;
//   final DateTime createdAt;
//   final String? createdBy;
//   final DateTime lastModified;
//   final String? lastModifiedBy;
//
//   const CommentModel({
//     required this.userId,
//     required this.postId,
//     this.post,
//     this.parentCommentId,
//     this.parentComment,
//     required this.content,
//     required this.mediaUrl,
//     required this.voteCount,
//     required this.commentVotes,
//     required this.replyCount,
//     required this.isDeleted,
//     required this.id,
//     required this.createdAt,
//     this.createdBy,
//     required this.lastModified,
//     this.lastModifiedBy,
//   });
//
//   factory CommentModel.fromJson(Map<String, dynamic> json) {
//     return CommentModel(
//       userId: json['userId'] ?? '',
//       postId: json['postId'] ?? '',
//       post: json['post'] ?? '',
//       parentCommentId: json['parentCommentId'] ?? '',
//       parentComment: json['parentComment'] ?? '',
//       content: json['content'] ?? '',
//       mediaUrl: json['mediaUrl'] ?? '',
//       voteCount: json['voteCount'] ?? 0,
//       commentVotes: json['commentVotes'] ?? [],
//       replyCount: json['replyCount'] ?? 0,
//       isDeleted: json['isDeleted'] ?? false,
//       id: json['id'] ?? '',
//       createdAt: json['createdAt'],
//       createdBy: json['createdBy'],
//       lastModified: json['lastModified'],
//       lastModifiedBy: json['lastModifiedBy']
//     );
//   }
// }

import 'package:fitora_mobile_app/feature/post/data/models/responses/comment_response_model.dart';

class CommentModel {
  final String id;
  final String userId;
  final String postId;
  final String? post;
  final String? parentCommentId;
  final String? parentComment;
  final String content;
  final String mediaUrl;
  final int voteCount;
  final int? score;
  final int replyCount;
  final List<String>? commentVotes;
  final int? userVoteType;
  final bool isDeleted;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final UserModel? user;

  const CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    this.post,
    this.parentCommentId,
    this.parentComment,
    required this.content,
    required this.mediaUrl,
    required this.voteCount,
    this.score,
    required this.replyCount,
    this.commentVotes,
    this.userVoteType,
    required this.isDeleted,
    this.createdBy,
    this.createdAt,
    this.lastModified,
    this.lastModifiedBy,
    this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      postId: json['postId'] ?? '',
      post: json['post'] ?? '',
      parentCommentId: json['parentCommentId'],
      parentComment: json['parentComment'] ?? '',
      content: json['content'] ?? '',
      mediaUrl: json['mediaUrl'] ?? '',
      voteCount: json['votes'] ?? json['voteCount'] ?? 0,
      score: json['score'],
      replyCount: json['replyCount'] ?? 0,
      commentVotes: (json['commentVotes'] as List?)?.map((e) => e.toString()).toList(),
      userVoteType: json['userVoteType'],
      isDeleted: json['isDeleted'] ?? false,
      createdBy: json['createdBy'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      lastModified: json['lastModified'] != null ? DateTime.tryParse(json['lastModified']) : null,
      lastModifiedBy: json['lastModifiedBy'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

