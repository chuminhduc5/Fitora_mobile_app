// class CommentEntity {
//   final String id;
//   final String userId;
//   final String postId;
//   final String? parentCommentId;
//   final String content;
//   final String mediaUrl;
//   final int votes;
//   final int replyCount;
//   final bool isDeleted;
//   final DateTime createdAt;
//   final DateTime lastModified;
//   final UserEntity? user;
//   final PostEntity? post;
//
//   CommentEntity({
//     required this.id,
//     required this.userId,
//     required this.postId,
//     this.parentCommentId,
//     required this.content,
//     required this.mediaUrl,
//     required this.votes,
//     required this.replyCount,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.lastModified,
//     this.user,
//     this.post,
//   });
// }
//
// class UserEntity {
//   final String id;
//   final bool isFriend;
//   final bool isFollowing;
//   final String email;
//   final String username;
//   final String firstName;
//   final String lastName;
//   final DateTime? birthDate;
//   final int gender;
//   final String address;
//   final String phoneNumber;
//   final String profilePictureUrl;
//   final String? bio;
//
//   UserEntity({
//     required this.id,
//     required this.isFriend,
//     required this.isFollowing,
//     required this.email,
//     required this.username,
//     required this.firstName,
//     required this.lastName,
//     this.birthDate,
//     required this.address,
//     required this.phoneNumber,
//     required this.profilePictureUrl,
//     this.bio,
//     required this.gender,
//   });
// }
//
// class PostEntity {
//   final String userId;
//   final String? groupId;
//   final String content;
//   final String mediaUrl;
//   final int privacy;
//   final bool isDeleted;
//   final int votesCount;
//   final List<dynamic> userVoteds;
//   final String? categoryId;
//   final dynamic category;
//   final bool isApproved;
//   final int commentsCount;
//   final dynamic score;
//   final String id;
//   final DateTime createdAt;
//   final String createdBy;
//   final DateTime lastModified;
//   final dynamic lastModifiedBy;
//
//   PostEntity({
//     required this.userId,
//     this.groupId,
//     required this.content,
//     required this.mediaUrl,
//     required this.privacy,
//     required this.isDeleted,
//     required this.votesCount,
//     required this.userVoteds,
//     this.categoryId,
//     this.category,
//     required this.isApproved,
//     required this.commentsCount,
//     this.score,
//     required this.id,
//     required this.createdAt,
//     required this.createdBy,
//     required this.lastModified,
//     this.lastModifiedBy,
//   });
// }


import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String userId;
  final String postId;
  final String? parentCommentId;
  final String? parentComment;
  final String content;
  final String mediaUrl;
  final int votes;
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
    this.parentCommentId,
    this.parentComment,
    required this.content,
    required this.mediaUrl,
    required this.votes,
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
    parentCommentId,
    parentComment,
    content,
    mediaUrl,
    votes,
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

class UserEntity extends Equatable {
  final String id;
  final bool isFriend;
  final bool isFollowing;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final int gender;
  final String? address;
  final String phoneNumber;
  final String profilePictureUrl;
  final String bio;

  const UserEntity({
    required this.id,
    required this.isFriend,
    required this.isFollowing,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.bio,
  });

  @override
  List<Object?> get props => [
    id,
    isFriend,
    isFollowing,
    email,
    username,
    firstName,
    lastName,
    birthDate,
    gender,
    address,
    phoneNumber,
    profilePictureUrl,
    bio,
  ];
}
