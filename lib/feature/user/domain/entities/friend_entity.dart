import 'package:equatable/equatable.dart';

class FriendEntity extends Equatable {
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

  const FriendEntity({
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

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    firstName,
    birthDate,
    gender,
    address,
    phoneNumber,
    profilePictureUrl,
    bio,
  ];
}