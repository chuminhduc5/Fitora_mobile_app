import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String userId;
  final String postId;
  final String? parentCommentId;
  final String content;
  final String mediaUrl;
  final int votes;
  final int replyCount;
  final int? score;
  final UserEntity user;
  final int? userVoteType;
  final bool isDeleted;

  const CommentEntity({
    required this.id,
    required this.userId,
    required this.postId,
    this.parentCommentId,
    required this.content,
    required this.mediaUrl,
    required this.votes,
    required this.replyCount,
    this.score,
    required this.user,
    this.userVoteType,
    required this.isDeleted,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    postId,
    parentCommentId,
    content,
    mediaUrl,
    votes,
    replyCount,
    score,
    user,
    userVoteType,
    isDeleted,
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
