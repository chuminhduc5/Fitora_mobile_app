import 'package:equatable/equatable.dart';

class GroupMemberEntity extends Equatable {
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

  const GroupMemberEntity({
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

  @override
  List<Object?> get props => [
    id,
    groupId,
    groupName,
    groupDescription,
    groupPictureUrl,
    groupBackgroundPictureUrl,
    userId,
    userName,
    email,
    firstName,
    lastName,
    birthDate,
    gender,
    address,
    phoneNumber,
    profilePictureUrl,
    profileBackgroundPictureUrl,
    bio,
    role,
    joinedAt,
  ];
}