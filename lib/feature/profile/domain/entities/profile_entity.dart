import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String email;
  final String username;
  final int followerCount;
  final int followingCount;
  final RelationshipEntity relationship;
  final UserInfoEntity userInfo;

  const ProfileEntity({
    required this.email,
    required this.username,
    required this.followerCount,
    required this.followingCount,
    required this.relationship,
    required this.userInfo,
  });

  @override
  List<Object?> get props => [
        email,
        username,
        followerCount,
        followingCount,
        relationship,
        userInfo,
      ];
}

class RelationshipEntity extends Equatable {
  final bool isFriend;
  final bool isFriendRequest;
  final bool isFollowing;

  const RelationshipEntity({
    required this.isFriend,
    required this.isFriendRequest,
    required this.isFollowing,
  });

  @override
  List<Object?> get props => [isFriend, isFriendRequest, isFollowing];
}

class UserInfoEntity extends Equatable {
  final String userId;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final int gender;
  final String address;
  final String phoneNumber;
  final String profilePictureUrl;
  final String profileBackgroundPictureUrl;
  final String bio;
  final String id;
  final DateTime createdAt;
  final DateTime? createdBy;
  final DateTime lastModified;
  final DateTime? lastModifiedBy;

  const UserInfoEntity({
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

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        birthDate,
        gender,
        address,
        phoneNumber,
        profilePictureUrl,
        profileBackgroundPictureUrl,
        bio,
        id,
        createdAt,
        createdBy,
        lastModified,
        lastModifiedBy,
      ];
}
