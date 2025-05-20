import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/feature/post/data/models/responses/comment_response_model.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_response_entity.dart';

// class CommentEntity extends Equatable {
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
//   const CommentEntity({
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
//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//         userId,
//         postId,
//         post,
//         parentCommentId,
//         parentComment,
//         content,
//         mediaUrl,
//         voteCount,
//         commentVotes,
//         replyCount,
//         isDeleted,
//         id,
//         createdAt,
//         createdBy,
//         lastModified,
//         lastModifiedBy,
//       ];
// }

class CommentEntity extends Equatable {
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
  final UserEntity? user;

  const CommentEntity({
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

  @override
  List<Object?> get props => [
        userId,
        postId,
        post,
        parentCommentId,
        parentComment,
        content,
        mediaUrl,
        voteCount,
        commentVotes,
        replyCount,
        score,
        userVoteType,
        isDeleted,
        id,
        createdAt,
        createdBy,
        lastModified,
        lastModifiedBy,
        user,
      ];
}
