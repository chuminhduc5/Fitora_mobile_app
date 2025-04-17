import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/get_profile_use_case.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/update_profile_use_case.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/forms/profile_form_data.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  ProfileBloc(
    this._getProfileUseCase,
    this._updateProfileUseCase,
  ) : super(ProfileInitialState()) {
    on<FetchProfileEvent>(_fetchProfile);
    on<UpdateProfileEvent>(_updateProfile);
  }

  Future _fetchProfile(FetchProfileEvent event, Emitter emit) async {
    emit(FetchProfileLoadingState());

    final result = await _getProfileUseCase.call(NoParams());

    result.fold(
      (failure) => emit(FetchProfileFailureState(mapFailureToMessage(failure))),
      (data) => emit(FetchProfileSuccessState(data: data)),
    );
  }

  Future _updateProfile(UpdateProfileEvent event, Emitter emit) async {
    emit(UpdateProfileLoadingState());

    final result = await _updateProfileUseCase.call(
      UpdateProfileParams(
        id: event.params.id,
        userId: event.params.userId,
        firstName: event.params.firstName,
        lastName: event.params.lastName,
        birthDate: event.params.birthDate,
        gender: event.params.gender,
        address: event.params.address,
        phoneNumber: event.params.phoneNumber,
        profilePictureUrl: event.params.profilePictureUrl,
        profileBackgroundPictureUrl: event.params.profileBackgroundPictureUrl,
        bio: event.params.bio,
      ),
    );

    result.fold(
      (failure) => emit(UpdateProfileFailureState(mapFailureToMessage(failure))),
      (success) => emit(UpdateProfileSuccessState()),
    );
  }
}
