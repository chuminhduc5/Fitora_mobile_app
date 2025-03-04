import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/get_profile_use_case.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileBloc(this._getProfileUseCase) : super(ProfileInitialState()) {
    on<FetchProfileEvent>(_fetchProfile);
  }

  Future _fetchProfile(FetchProfileEvent event, Emitter emit) async {
    emit(FetchProfileLoadingState());

    final result = await _getProfileUseCase.call(NoParams());

    result.fold(
      (failure) => emit(FetchProfileFailureState(mapFailureToMessage(failure))),
      (data) => emit(FetchProfileSuccessState(data: data)),
    );
  }
}
