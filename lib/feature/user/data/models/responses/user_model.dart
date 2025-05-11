class UserModel {
  final String id;
  final bool? isFriend;
  final bool? isFollowing;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String birthDate;
  final int gender;
  final String address;
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
      id: json['id'] ?? "",
      isFriend: json['isFriend'],
      isFollowing: json['isFollowing'],
      email: json['email'] ?? "",
      username: json['username'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      birthDate: json['birthDate'] ?? "",
      gender: json['gender'] ?? 0,
      address: json['address'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      profilePictureUrl: json['profilePictureUrl'] ?? "",
      bio: json['bio'] ?? "",
    );
  }
}
