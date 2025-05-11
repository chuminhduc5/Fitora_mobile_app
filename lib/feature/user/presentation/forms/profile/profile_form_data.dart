class ProfileFormData {
  final String id;
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

  const ProfileFormData({
    required this.id,
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
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "birthDate": birthDate.toIso8601String(),
      "gender": gender,
      "address": address,
      "phoneNumber": phoneNumber,
      "profilePictureUrl": profilePictureUrl,
      "profileBackgroundPictureUrl": profileBackgroundPictureUrl,
      "bio": bio,
    };
  }
}
