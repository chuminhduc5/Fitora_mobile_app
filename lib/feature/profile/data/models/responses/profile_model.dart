class ProfileModel {
  final String email;
  final String username;
  final int followerCount;
  final int followingCount;
  final RelationshipModel relationship;
  final UserInfoModel userInfo;

  const ProfileModel({
    required this.email,
    required this.username,
    required this.followerCount,
    required this.followingCount,
    required this.relationship,
    required this.userInfo,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'],
      username: json['username'],
      followerCount: json['followerCount'],
      followingCount: json['followingCount'],
      relationship: RelationshipModel.fromJson(json['relationship']),
      userInfo: UserInfoModel.fromJson(json['userInfo']),
    );
  }
}

class RelationshipModel {
  final bool isFriend;
  final bool isFriendRequest;
  final bool isFollowing;

  const RelationshipModel({
    required this.isFriend,
    required this.isFriendRequest,
    required this.isFollowing,
  });

  factory RelationshipModel.fromJson(Map<String, dynamic> json) {
    return RelationshipModel(
      isFriend: json['isFriend'],
      isFriendRequest: json['isFriendRequest'],
      isFollowing: json['isFollowing'],
    );
  }
}

class UserInfoModel {
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
  final DateTime createdBy;
  final DateTime lastModified;
  final DateTime lastModifiedBy;

  const UserInfoModel({
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
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: DateTime.parse(json['birthDate']),
      gender: json['gender'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      profilePictureUrl: json['profilePictureUrl'],
      profileBackgroundPictureUrl: json['profileBackgroundPictureUrl'],
      bio: json['bio'],
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      createdBy: DateTime.parse(json['createdBy']),
      lastModified: DateTime.parse(json['lastModified']),
      lastModifiedBy: DateTime.parse(json['lastModifiedBy']),
    );
  }
}
