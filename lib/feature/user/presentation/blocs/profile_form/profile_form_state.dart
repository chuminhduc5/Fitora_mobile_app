part of 'profile_form_bloc.dart';

@immutable
abstract class ProfileFormState extends Equatable {
  final UpdateProfileFormData data;

  const ProfileFormState(this.data);

  @override
  List<Object?> get props => [data];
}

class ProfileFormInitialState extends ProfileFormState {
  ProfileFormInitialState()
      : super(
    UpdateProfileFormData(
      firstName: "",
      lastName: "",
      birthDate: DateTime(2000, 1, 1),
      gender: 1,
      address: "",
      phoneNumber: "",
      profilePictureUrl: "",
      profileBackgroundPictureUrl: "",
      bio: "",
      isValid: false,
    ),
  );
}

class ProfileFormDataState extends ProfileFormState {
  final UpdateProfileFormInputData inputData;

  ProfileFormDataState(this.inputData)
      : super(
    UpdateProfileFormData(
      firstName: inputData.inputFirstName,
      lastName: inputData.inputLastName,
      birthDate: inputData.inputBirthDate,
      gender: inputData.inputGender,
      address: inputData.inputAddress,
      phoneNumber: inputData.inputPhoneNumber,
      profilePictureUrl: inputData.inputProfilePictureUrl,
      profileBackgroundPictureUrl: inputData.inputProfileBackgroundPictureUrl,
      bio: inputData.inputBio,
      isValid: inputData.inputIsValid,
    ),
  );
}

