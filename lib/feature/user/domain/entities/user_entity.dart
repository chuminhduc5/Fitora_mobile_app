import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
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

  const UserEntity({
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

  @override
  List<Object?> get props => [
        id,
        isFriend,
        isFollowing,
        email,
        username,
        firstName,
        lastName,
        birthDate,
        gender,
        address,
        phoneNumber,
        profilePictureUrl,
        bio,
      ];
}
