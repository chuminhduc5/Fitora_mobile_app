import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/feature/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase extends UseCase<void, Params> {
  final ProfileRepository _profileRepository;

  UpdateProfileUseCase(this._profileRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _profileRepository.updateProfile(params);
  }
}

class Params extends Equatable {
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

  const Params({
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

  @override
  List<Object?> get props => [
        id,
        userId,
        firstName,
        lastName,
        birthDate,
        gender,
        address,
        phoneNumber,
        profilePictureUrl,
        profileBackgroundPictureUrl,
        bio,
      ];
}
