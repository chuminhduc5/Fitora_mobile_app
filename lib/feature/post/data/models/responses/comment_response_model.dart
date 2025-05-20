import 'package:fitora_mobile_app/feature/post/domain/entities/comment_response_entity.dart';

class CommentResponseModel {
  final String id;
  final String userId;
  final String postId;
  final String? parentCommentId;
  final String content;
  final String mediaUrl;
  final int votes;
  final int replyCount;
  final int? score;
  final UserModel user;
  final int? userVoteType;
  final bool isDeleted;

  const CommentResponseModel({
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

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) {
    return CommentResponseModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      postId: json['postId'] ?? '',
      parentCommentId: json['parentCommentId'],
      content: json['content'] ?? '',
      mediaUrl: json['mediaUrl'] ?? '',
      votes: json['votes'] ?? 0,
      replyCount: json['replyCount'] ?? 0,
      score: json['score'],
      user: UserModel.fromJson(json['user']),
      userVoteType: json['userVoteType'],
      isDeleted: json['isDeleted'] ?? false,
    );
  }
}

class UserModel {
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

  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      isFriend: json['isFriend'] ?? false,
      isFollowing: json['isFollowing'] ?? false,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
      gender: json['gender'] ?? 0,
      address: json['address'],
      phoneNumber: json['phoneNumber'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      bio: json['bio'] ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      isFriend: isFriend,
      isFollowing: isFollowing,
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      gender: gender,
      address: address,
      phoneNumber: phoneNumber,
      profilePictureUrl: profilePictureUrl,
      bio: bio,
    );
  }
}