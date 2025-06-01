// import 'package:hive/hive.dart';
//
// @HiveType(typeId: 1)
// class UserProfileModel extends HiveObject {
//   @HiveField(0)
//   final String email;
//
//   @HiveField(1)
//   final String username;
//
//   @HiveField(2)
//   final int followerCount;
//
//   @HiveField(3)
//   final int followingCount;
//
//   @HiveField(4)
//   final RelationshipModel relationship;
//
//   @HiveField(5)
//   final UserInfoModel userInfo;
//
//   UserProfileModel({
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
// @HiveType(typeId: 2)
// class RelationshipModel extends HiveObject {
//   @HiveField(0)
//   final bool isFriend;
//
//   @HiveField(1)
//   final bool isFriendRequest;
//
//   @HiveField(2)
//   final bool isFollowing;
//
//   RelationshipModel({
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
// }
//
// @HiveType(typeId: 3)
// class UserInfoModel extends HiveObject {
//   @HiveField(0)
//   final String userId;
//
//   @HiveField(1)
//   final String firstName;
//
//   @HiveField(2)
//   final String lastName;
//
//   @HiveField(3)
//   final DateTime birthDate;
//
//   @HiveField(4)
//   final int gender;
//
//   @HiveField(5)
//   final String address;
//
//   @HiveField(6)
//   final String phoneNumber;
//
//   @HiveField(7)
//   final String profilePictureUrl;
//
//   @HiveField(8)
//   final String profileBackgroundPictureUrl;
//
//   @HiveField(9)
//   final String bio;
//
//   @HiveField(10)
//   final String id;
//
//   @HiveField(11)
//   final DateTime createdAt;
//
//   @HiveField(12)
//   final String? createdBy;
//
//   @HiveField(13)
//   final DateTime lastModified;
//
//   @HiveField(14)
//   final String? lastModifiedBy;
//
//   UserInfoModel({
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
//       createdBy: json['createdBy'],
//       lastModified: DateTime.parse(json['lastModified']),
//       lastModifiedBy: json['lastModifiedBy'],
//     );
//   }
// }