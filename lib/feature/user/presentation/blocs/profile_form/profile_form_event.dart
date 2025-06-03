part of 'profile_form_bloc.dart';

@immutable
abstract class ProfileFormEvent extends Equatable {
  const ProfileFormEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện người dùng thay đổi FirstName
class ProfileFormFirstNameChangedEvent extends ProfileFormEvent {
  final String firstName;

  const ProfileFormFirstNameChangedEvent(this.firstName);

  @override
  List<Object?> get props => [firstName];
}

// Sự kiện người dùng thay đổi LastName
class ProfileFormLastNameChangedEvent extends ProfileFormEvent {
  final String lastName;

  const ProfileFormLastNameChangedEvent(this.lastName);

  @override
  List<Object?> get props => [lastName];
}

// Sự kiện người dùng thay đổi BirthDate
class ProfileFormBirthDateChangedEvent extends ProfileFormEvent {
  final DateTime date;

  const ProfileFormBirthDateChangedEvent(this.date);

  @override
  List<Object?> get props => [date];
}

// Sự kiện người dùng thay đổi Gender
class ProfileFormGenderChangedEvent extends ProfileFormEvent {
  final int gender;

  const ProfileFormGenderChangedEvent(this.gender);

  @override
  List<Object?> get props => [gender];
}

// Sự kiện người dùng thay đổi Address
class ProfileFormAddressChangedEvent extends ProfileFormEvent {
  final String address;

  const ProfileFormAddressChangedEvent(this.address);

  @override
  List<Object?> get props => [address];
}

// Sự kiện người dùng thay đổi PhoneNumber
class ProfileFormPhoneNumberChangedEvent extends ProfileFormEvent {
  final String phoneNumber;

  const ProfileFormPhoneNumberChangedEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

// Sự kiện người dùng thay đổi ProfilePictureUrl
class ProfileFormProfilePictureUrlChangedEvent extends ProfileFormEvent {
  final String profilePictureUrl;

  const ProfileFormProfilePictureUrlChangedEvent(this.profilePictureUrl);

  @override
  List<Object?> get props => [profilePictureUrl];
}

// Sự kiện người dùng thay đổi ProfileBackgroundPictureUrl
class ProfileFormProfileBackgroundPictureUrlChangedEvent extends ProfileFormEvent {
  final String profileBackgroundPictureUrl;

  const ProfileFormProfileBackgroundPictureUrlChangedEvent(this.profileBackgroundPictureUrl);

  @override
  List<Object?> get props => [profileBackgroundPictureUrl];
}

// Sự kiện người dùng thay đổi Bio
class ProfileFormBioChangedEvent extends ProfileFormEvent {
  final String bio;

  const ProfileFormBioChangedEvent(this.bio);

  @override
  List<Object?> get props => [bio];
}