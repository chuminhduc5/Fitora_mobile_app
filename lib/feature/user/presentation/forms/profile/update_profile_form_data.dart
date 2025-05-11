import 'package:equatable/equatable.dart';

class UpdateProfileFormData extends Equatable {
  // final String id;
  // final String userId;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final int gender;
  final String address;
  final String phoneNumber;
  final String profilePictureUrl;
  final String profileBackgroundPictureUrl;
  final String bio;
  final bool isValid;

  const UpdateProfileFormData({
    // required this.id,
    // required this.userId,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.profileBackgroundPictureUrl,
    required this.bio,
    required this.isValid,
  });

  @override
  List<Object?> get props => [
        // id,
        // userId,
        firstName,
        lastName,
        birthDate,
        gender,
        address,
        phoneNumber,
        profilePictureUrl,
        profileBackgroundPictureUrl,
        bio,
        isValid,
      ];

  UpdateProfileFormData copyWith({
    // final String? id,
    // final String? userId,
    final String? firstName,
    final String? lastName,
    final DateTime? birthDate,
    final int? gender,
    final String? address,
    final String? phoneNumber,
    final String? profilePictureUrl,
    final String? profileBackgroundPictureUrl,
    final String? bio,
    final bool? isValid,
  }) {
    return UpdateProfileFormData(
      // id: id ?? this.id,
      // userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      profileBackgroundPictureUrl: profileBackgroundPictureUrl ?? this.profileBackgroundPictureUrl,
      bio: bio ?? this.bio,
      isValid: isValid ?? this.isValid,
    );
  }
}
