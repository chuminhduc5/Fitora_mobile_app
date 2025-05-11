import 'package:equatable/equatable.dart';

class UpdateProfileFormInputData extends Equatable {
  // final String inputId;
  // final String inputUserId;
  final String inputFirstName;
  final String inputLastName;
  final DateTime inputBirthDate;
  final int inputGender;
  final String inputAddress;
  final String inputPhoneNumber;
  final String inputProfilePictureUrl;
  final String inputProfileBackgroundPictureUrl;
  final String inputBio;
  final bool inputIsValid;

  const UpdateProfileFormInputData({
    // required this.inputId,
    // required this.inputUserId,
    required this.inputFirstName,
    required this.inputLastName,
    required this.inputBirthDate,
    required this.inputGender,
    required this.inputAddress,
    required this.inputPhoneNumber,
    required this.inputProfilePictureUrl,
    required this.inputProfileBackgroundPictureUrl,
    required this.inputBio,
    required this.inputIsValid,
  });

  @override
  List<Object?> get props => [
    // inputId,
    // inputUserId,
    inputFirstName,
    inputLastName,
    inputBirthDate,
    inputGender,
    inputAddress,
    inputPhoneNumber,
    inputProfilePictureUrl,
    inputProfileBackgroundPictureUrl,
    inputBio,
    inputIsValid,
  ];

  UpdateProfileFormInputData copyWith({
    // final String? inputId,
    // final String? inputUserId,
    final String? inputFirstName,
    final String? inputLastName,
    final DateTime? inputBirthDate,
    final int? inputGender,
    final String? inputAddress,
    final String? inputPhoneNumber,
    final String? inputProfilePictureUrl,
    final String? inputProfileBackgroundPictureUrl,
    final String? inputBio,
    final bool? inputIsValid,
  }) {
    return UpdateProfileFormInputData(
      // inputId: inputId ?? this.inputId,
      // inputUserId: inputUserId ?? this.inputUserId,
      inputFirstName: inputFirstName ?? this.inputFirstName,
      inputLastName: inputLastName ?? this.inputLastName,
      inputBirthDate: inputBirthDate ?? this.inputBirthDate,
      inputGender: inputGender ?? this.inputGender,
      inputAddress: inputAddress ?? this.inputAddress,
      inputPhoneNumber: inputPhoneNumber ?? this.inputPhoneNumber,
      inputProfilePictureUrl: inputProfilePictureUrl ?? this.inputProfilePictureUrl,
      inputProfileBackgroundPictureUrl: inputProfileBackgroundPictureUrl ?? this.inputProfileBackgroundPictureUrl,
      inputBio: inputBio ?? this.inputBio,
      inputIsValid: inputIsValid ?? this.inputIsValid,
    );
  }
}