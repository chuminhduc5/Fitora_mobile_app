import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String groupId;
  final String categoryId;
  final String categoryName;
  final String content;
  final String mediaUrl;
  final int votesCount;
  final int commentsCount;
  final double score;
  final int privacy;
  final DateTime? createAt;
  final DateTime? updateAt;
  final bool isDeleted;
  final UserEntity user;
  final int? userVoteType;

  const PostEntity({
    required this.id,
    required this.groupId,
    required this.categoryId,
    required this.categoryName,
    required this.content,
    required this.mediaUrl,
    required this.votesCount,
    required this.commentsCount,
    required this.score,
    required this.privacy,
    required this.createAt,
    required this.updateAt,
    required this.isDeleted,
    required this.user,
    this.userVoteType,
  });

  @override
  List<Object?> get props => [
    id,
    groupId,
    categoryId,
    categoryName,
    content,
    mediaUrl,
    votesCount,
    commentsCount,
    score,
    privacy,
    createAt,
    updateAt,
    isDeleted,
    user,
    userVoteType,
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
