class FriendModel {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String birthDate;
  final int gender;
  final String address;
  final String phoneNumber;
  final String profilePictureUrl;
  final String bio;

  const FriendModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.bio,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      birthDate: json['birthDate'],
      gender: json['gender'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      profilePictureUrl: json['profilePictureUrl'],
      bio: json['bio'],
    );
  }
}
