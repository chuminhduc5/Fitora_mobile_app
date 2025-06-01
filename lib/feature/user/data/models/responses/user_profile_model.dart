import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
//
// class UserProfileModel {
//   final String email;
//   final String username;
//   final int followerCount;
//   final int followingCount;
//   final RelationshipModel relationship;
//   final UserInfoModel userInfo;
//
//   const UserProfileModel({
//     required this.email,
//     required this.username,
//     required this.followerCount,
//     required this.followingCount,
//     required this.relationship,
//     required this.userInfo,
//   });
//
//   factory UserProfileModel.fromJson(Map<String, dynamic> json) {
//     return UserProfileModel(
//       email: json['email'] ?? "",
//       username: json['userName'] ?? "",
//       followerCount: json['followerCount'] ?? 0,
//       followingCount: json['followingCount'] ?? 0,
//       relationship: RelationshipModel.fromJson(json['relationship']),
//       userInfo: UserInfoModel.fromJson(json['userInfo']),
//     );
//   }
// }
//
// class RelationshipModel {
//   final bool isFriend;
//   final bool isFriendRequest;
//   final bool isFollowing;
//
//   const RelationshipModel({
//     required this.isFriend,
//     required this.isFriendRequest,
//     required this.isFollowing,
//   });
//
//   factory RelationshipModel.fromJson(Map<String, dynamic> json) {
//     return RelationshipModel(
//       isFriend: json['isFriend'],
//       isFriendRequest: json['isFriendRequest'],
//       isFollowing: json['isFollowing'],
//     );
//   }
//
//   RelationshipEntity toEntity() {
//     return RelationshipEntity(
//       isFriend: isFriend,
//       isFriendRequest: isFriendRequest,
//       isFollowing: isFollowing,
//     );
//   }
// }
//
// class UserInfoModel {
//   final String userId;
//   final String firstName;
//   final String lastName;
//   final DateTime birthDate;
//   final int gender;
//   final String address;
//   final String phoneNumber;
//   final String profilePictureUrl;
//   final String profileBackgroundPictureUrl;
//   final String bio;
//   final String id;
//   final DateTime createdAt;
//   final String? createdBy;
//   final DateTime lastModified;
//   final String? lastModifiedBy;
//
//   const UserInfoModel({
//     required this.userId,
//     required this.firstName,
//     required this.lastName,
//     required this.birthDate,
//     required this.gender,
//     required this.address,
//     required this.phoneNumber,
//     required this.profilePictureUrl,
//     required this.profileBackgroundPictureUrl,
//     required this.bio,
//     required this.id,
//     required this.createdAt,
//     this.createdBy,
//     required this.lastModified,
//     this.lastModifiedBy,
//   });
//
//   factory UserInfoModel.fromJson(Map<String, dynamic> json) {
//     return UserInfoModel(
//       userId: json['userId'] ?? "",
//       firstName: json['firstName'] ?? "",
//       lastName: json['lastName'] ?? "",
//       birthDate: DateTime.parse(json['birthDate']),
//       gender: json['gender'] ?? 0,
//       address: json['address'] ?? "",
//       phoneNumber: json['phoneNumber'] ?? "",
//       profilePictureUrl: json['profilePictureUrl'] ?? "",
//       profileBackgroundPictureUrl: json['profileBackgroundPictureUrl'] ?? "",
//       bio: json['bio'] ?? "",
//       id: json['id'] ?? "",
//       createdAt: DateTime.parse(json['createdAt']),
//       createdBy: json['createdBy'] ?? "",
//       lastModified: DateTime.parse(json['lastModified']),
//       lastModifiedBy: json['lastModifiedBy'] ?? "",
//     );
//   }
//
//   UserInfoEntity toEntity() {
//     return UserInfoEntity(
//       userId: userId,
//       firstName: firstName,
//       lastName: lastName,
//       birthDate: birthDate,
//       gender: gender,
//       address: address,
//       phoneNumber: phoneNumber,
//       profilePictureUrl: profilePictureUrl,
//       profileBackgroundPictureUrl: profileBackgroundPictureUrl,
//       bio: bio,
//       id: id,
//       createdAt: createdAt,
//       lastModified: lastModified,
//     );
//   }
// }

import 'package:hive/hive.dart';

part 'user_profile_model.g.dart'; // Tệp được tạo tự động bởi build_runner

@HiveType(typeId: 0)
class UserProfileModel extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final int followerCount;

  @HiveField(3)
  final int followingCount;

  @HiveField(4)
  final RelationshipModel relationship;

  @HiveField(5)
  final UserInfoModel userInfo;

  UserProfileModel({
    required this.email,
    required this.username,
    required this.followerCount,
    required this.followingCount,
    required this.relationship,
    required this.userInfo,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      email: json['email'] ?? "",
      username: json['userName'] ?? "",
      followerCount: json['followerCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      relationship: RelationshipModel.fromJson(json['relationship']),
      userInfo: UserInfoModel.fromJson(json['userInfo']),
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      email: email,
      username: username,
      followerCount: followerCount,
      followingCount: followingCount,
      relationship: relationship.toEntity(),
      userInfo: userInfo.toEntity(),
    );
  }
}

@HiveType(typeId: 1)
class RelationshipModel extends HiveObject {
  @HiveField(0)
  final bool isFriend;

  @HiveField(1)
  final bool isFriendRequest;

  @HiveField(2)
  final bool isFollowing;

  RelationshipModel({
    required this.isFriend,
    required this.isFriendRequest,
    required this.isFollowing,
  });

  factory RelationshipModel.fromJson(Map<String, dynamic> json) {
    return RelationshipModel(
      isFriend: json['isFriend'] ?? false,
      isFriendRequest: json['isFriendRequest'] ?? false,
      isFollowing: json['isFollowing'] ?? false,
    );
  }

  RelationshipEntity toEntity() {
    return RelationshipEntity(
      isFriend: isFriend,
      isFriendRequest: isFriendRequest,
      isFollowing: isFollowing,
    );
  }
}

@HiveType(typeId: 2)
class UserInfoModel extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final DateTime birthDate;

  @HiveField(4)
  final int gender;

  @HiveField(5)
  final String address;

  @HiveField(6)
  final String phoneNumber;

  @HiveField(7)
  final String profilePictureUrl;

  @HiveField(8)
  final String profileBackgroundPictureUrl;

  @HiveField(9)
  final String bio;

  @HiveField(10)
  final String id;

  @HiveField(11)
  final DateTime createdAt;

  @HiveField(12)
  final String? createdBy;

  @HiveField(13)
  final DateTime lastModified;

  @HiveField(14)
  final String? lastModifiedBy;

  UserInfoModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.profileBackgroundPictureUrl,
    required this.bio,
    required this.id,
    required this.createdAt,
    this.createdBy,
    required this.lastModified,
    this.lastModifiedBy,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      userId: json['userId'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      birthDate: DateTime.parse(json['birthDate'] ?? DateTime.now().toIso8601String()),
      gender: json['gender'] ?? 0,
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      profilePictureUrl: json['profilePictureUrl'] ?? "",
      profileBackgroundPictureUrl: json['profileBackgroundPictureUrl'] ?? "",
      bio: json['bio'] ?? "",
      id: json['id'] ?? "",
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      createdBy: json['createdBy'],
      lastModified: DateTime.parse(json['lastModified'] ?? DateTime.now().toIso8601String()),
      lastModifiedBy: json['lastModifiedBy'],
    );
  }

  UserInfoEntity toEntity() {
    return UserInfoEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      gender: gender,
      address: address,
      phoneNumber: phoneNumber,
      profilePictureUrl: profilePictureUrl,
      profileBackgroundPictureUrl: profileBackgroundPictureUrl,
      bio: bio,
      id: id,
      createdAt: createdAt,
      createdBy: createdBy,
      lastModified: lastModified,
      lastModifiedBy: lastModifiedBy,
    );
  }
}