import 'package:fitora_mobile_app/feature/user/domain/entities/group_member_entity.dart';

class GroupMemberModel {
  final String id;
  final String groupId;
  final String groupName;
  final String groupDescription;
  final String groupPictureUrl;
  final String groupBackgroundPictureUrl;
  final String userId;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final int gender;
  final String address;
  final String phoneNumber;
  final String profilePictureUrl;
  final String profileBackgroundPictureUrl;
  final String bio;
  final int role;
  final DateTime joinedAt;

  const GroupMemberModel({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.groupDescription,
    required this.groupPictureUrl,
    required this.groupBackgroundPictureUrl,
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.profileBackgroundPictureUrl,
    required this.bio,
    required this.role,
    required this.joinedAt,
  });

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) {
    return GroupMemberModel(
      id: json['id'] ?? '',
      groupId: json['groupId'] ?? '',
      groupName: json['groupName'] ?? '',
      groupDescription: json['groupDescription'] ?? '',
      groupPictureUrl: json['groupPictureUrl'] ?? '',
      groupBackgroundPictureUrl: json['groupBackgroundPictureUrl'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthDate: DateTime.parse(
        json['birthDate'] ?? DateTime(1900).toIso8601String(),
      ),
      gender: json['gender'] ?? 0,
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      profileBackgroundPictureUrl: json['profileBackgroundPictureUrl'] ?? '',
      bio: json['bio'] ?? '',
      role: json['role'] ?? 0,
      joinedAt: DateTime.parse(
        json['joinedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  GroupMemberEntity toEntity() {
    return GroupMemberEntity(
      id: id,
      groupId: groupId,
      groupName: groupName,
      groupDescription: groupDescription,
      groupPictureUrl: groupPictureUrl,
      groupBackgroundPictureUrl: groupBackgroundPictureUrl,
      userId: userId,
      userName: userName,
      email: email,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      gender: gender,
      address: address,
      phoneNumber: phoneNumber,
      profilePictureUrl: profilePictureUrl,
      profileBackgroundPictureUrl: profileBackgroundPictureUrl,
      bio: bio,
      role: role,
      joinedAt: joinedAt,
    );
  }
}