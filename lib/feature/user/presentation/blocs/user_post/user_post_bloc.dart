import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_user_post_use_case.dart';
import 'package:meta/meta.dart';

part 'user_post_event.dart';

part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  final GetUserPostUseCase _getUserPostUseCase;

  UserPostBloc(this._getUserPostUseCase) : super(FetchUserPostInitialState()) {
    on<FetchUserPostEvent>(_fetchUserPost);
  }

  Future _fetchUserPost(FetchUserPostEvent event, Emitter emit) async {
    emit(FetchUserPostLoadingState());

    final result = await _getUserPostUseCase.call(event.userId);

    result.fold(
      (failure) => emit(FetchUserPostFailureState(mapFailureToMessage(failure))),
      (success) => emit(FetchUserPostSuccessState(data: success)),
    );
  }
}
