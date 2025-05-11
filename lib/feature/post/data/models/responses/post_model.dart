import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';

class PostModel {
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
  final DateTime createAt;
  final DateTime? updateAt;
  final bool isDeleted;
  final UserModel user;
  final int? userVoteType;

  const PostModel({
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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDateTime(String? dateTimeString) {
      if (dateTimeString == null) return null;
      final utcDateTime = DateTime.parse(dateTimeString).toUtc();
      return utcDateTime.add(const Duration(hours: 7));
    }
    print('DEBUG createAt: ${json['createdAt']}');
    return PostModel(
      id: json['id'] ?? '',
      groupId: json['groupId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      content: json['content'] ?? '',
      mediaUrl: json['mediaUrl'] ?? '',
      votesCount: json['votesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      privacy: json['privacy'] ?? 0,
      createAt: parseDateTime(json['createdAt']) ?? DateTime.now(),
      updateAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      isDeleted: json['isDeleted'] ?? false,
      user: UserModel.fromJson(json['user']),
      userVoteType: json['userVoteType'],
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
