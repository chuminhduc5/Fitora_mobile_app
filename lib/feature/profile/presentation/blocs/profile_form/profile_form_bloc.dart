import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/forms/update_profile_form_data.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/forms/update_profile_form_input_data.dart';
import 'package:meta/meta.dart';

part 'profile_form_event.dart';

part 'profile_form_state.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc() : super(ProfileFormInitialState()) {
    on<ProfileFormFirstNameChangedEvent>(_firstNameChanged);
    on<ProfileFormLastNameChangedEvent>(_lastNameChanged);
    on<ProfileFormBirthDateChangedEvent>(_birthDateChanged);
    on<ProfileFormGenderChangedEvent>(_genderChanged);
    on<ProfileFormAddressChangedEvent>(_addressChanged);
    on<ProfileFormPhoneNumberChangedEvent>(_phoneNumberChanged);
    on<ProfileFormProfilePictureUrlChangedEvent>(_profilePictureUrlChanged);
    on<ProfileFormProfileBackgroundPictureUrlChangedEvent>(
        _profileBackgroundPictureUrlChanged);
    on<ProfileFormBioChangedEvent>(_bioChanged);
  }

  // Thay đổi FirstName - Bloc
  Future<void> _firstNameChanged(
    ProfileFormFirstNameChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: event.firstName,
      inputLastName: state.data.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: state.data.gender,
      inputAddress: state.data.address,
      inputPhoneNumber: state.data.phoneNumber,
      inputProfilePictureUrl: state.data.profilePictureUrl,
      inputProfileBackgroundPictureUrl: state.data.profileBackgroundPictureUrl,
      inputBio: state.data.bio,
      inputIsValid: inputValidator(state.data.lastName!),
    );
    emit(ProfileFormDataState(updateData));
  }

  // Thay đổi LastName - Bloc
  Future<void> _lastNameChanged(
    ProfileFormLastNameChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: state.data.firstName,
      inputLastName: event.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: state.data.gender,
      inputAddress: state.data.address,
      inputPhoneNumber: state.data.phoneNumber,
      inputProfilePictureUrl: state.data.profilePictureUrl,
      inputProfileBackgroundPictureUrl: state.data.profileBackgroundPictureUrl,
      inputBio: state.data.bio,
      inputIsValid: inputValidator(event.lastName),
    );
    emit(ProfileFormDataState(updateData));
  }

  // Thay đổi BirthDate - Bloc
  Future<void> _birthDateChanged(
    ProfileFormBirthDateChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: state.data.firstName,
      inputLastName: state.data.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: state.data.gender,
      inputAddress: state.data.address,
      inputPhoneNumber: state.data.phoneNumber,
      inputProfilePictureUrl: state.data.profilePictureUrl,
      inputProfileBackgroundPictureUrl: state.data.profileBackgroundPictureUrl,
      inputBio: state.data.bio,
      inputIsValid: inputValidator(state.data.lastName!),
    );
    emit(ProfileFormDataState(updateData));
  }

  // Thay đổi Gender - Bloc
  Future<void> _genderChanged(
    ProfileFormGenderChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: state.data.firstName,
      inputLastName: state.data.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: event.gender,
      inputAddress: state.data.address,
      inputPhoneNumber: state.data.phoneNumber,
      inputProfilePictureUrl: state.data.profilePictureUrl,
      inputProfileBackgroundPictureUrl: state.data.profileBackgroundPictureUrl,
      inputBio: state.data.bio,
      inputIsValid: inputValidator(state.data.lastName!),
    );
    emit(ProfileFormDataState(updateData));
  }

  // Thay đổi Address - Bloc
  Future<void> _addressChanged(
    ProfileFormAddressChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: state.data.firstName,
      inputLastName: state.data.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: state.data.gender,
      inputAddress: event.address,
      inputPhoneNumber: state.data.phoneNumber,
      inputProfilePictureUrl: state.data.profilePictureUrl,
      inputProfileBackgroundPictureUrl: state.data.profileBackgroundPictureUrl,
      inputBio: state.data.bio,
      inputIsValid: inputValidator(state.data.lastName!),
    );
    emit(ProfileFormDataState(updateData));
  }

  // Thay đổi PhoneNumber - Bloc
  Future<void> _phoneNumberChanged(
    ProfileFormPhoneNumberChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: state.data.firstName,
      inputLastName: state.data.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: state.data.gender,
      inputAddress: state.data.address,
      inputPhoneNumber: event.phoneNumber,
      inputProfilePictureUrl: state.data.profilePictureUrl,
      inputProfileBackgroundPictureUrl: state.data.profileBackgroundPictureUrl,
      inputBio: state.data.bio,
      inputIsValid: inputValidator(state.data.lastName!),
    );
    emit(ProfileFormDataState(updateData));
  }

  // Thay đổi ProfilePictureUrl - Bloc
  Future<void> _profilePictureUrlChanged(
    ProfileFormProfilePictureUrlChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: state.data.firstName,
      inputLastName: state.data.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: state.data.gender,
      inputAddress: state.data.address,
      inputPhoneNumber: state.data.phoneNumber,
      inputProfilePictureUrl: event.profilePictureUrl,
      inputProfileBackgroundPictureUrl: state.data.profileBackgroundPictureUrl,
      inputBio: state.data.bio,
      inputIsValid: inputValidator(state.data.lastName!),
    );
    emit(ProfileFormDataState(updateData));
  }

  // Thay đổi ProfileBackgroundPictureUrl - Bloc
  Future<void> _profileBackgroundPictureUrlChanged(
    ProfileFormProfileBackgroundPictureUrlChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: state.data.firstName,
      inputLastName: state.data.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: state.data.gender,
      inputAddress: state.data.address,
      inputPhoneNumber: state.data.phoneNumber,
      inputProfilePictureUrl: state.data.profilePictureUrl,
      inputProfileBackgroundPictureUrl: event.profileBackgroundPictureUrl,
      inputBio: state.data.bio,
      inputIsValid: inputValidator(state.data.lastName!),
    );
    emit(ProfileFormDataState(updateData));
  }

  // Thay đổi Bio - Bloc
  Future<void> _bioChanged(
    ProfileFormBioChangedEvent event,
    Emitter emit,
  ) async {
    final updateData = UpdateProfileFormInputData(
      inputFirstName: state.data.firstName,
      inputLastName: state.data.lastName,
      inputBirthDate: state.data.birthDate,
      inputGender: state.data.gender,
      inputAddress: state.data.address,
      inputPhoneNumber: state.data.phoneNumber,
      inputProfilePictureUrl: state.data.profilePictureUrl,
      inputProfileBackgroundPictureUrl: state.data.profileBackgroundPictureUrl,
      inputBio: event.bio,
      inputIsValid: inputValidator(state.data.lastName!),
    );
    emit(ProfileFormDataState(updateData));
  }

  bool inputValidator(String lastName) {
    if (lastName.isNotEmpty) {
      return true;
    }

    return false;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE ProfileFormBloc =====");
    return super.close();
  }
}
