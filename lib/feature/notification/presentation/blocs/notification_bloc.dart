import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/friend_request_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/received_group_invite_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/get_received_friend_request_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_received_group_invite_use_case.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetReceivedFriendRequestUseCase _getReceivedFriendRequestUseCase;
  final GetReceivedGroupInviteUseCase _getReceivedGroupInviteUseCase;

  NotificationBloc(
    this._getReceivedFriendRequestUseCase,
    this._getReceivedGroupInviteUseCase,
  ) : super(NotificationInitialState()) {
    on<FetchReceivedFriendRequestEvent>(_fetchReceivedFriend);
    on<FetchReceivedGroupInviteEvent>(_fetchReceivedGroup);
  }

  Future _fetchReceivedFriend(
      FetchReceivedFriendRequestEvent event, Emitter emit) async {
    emit(FetchReceivedFriendRequestLoadingState());

    final result = await _getReceivedFriendRequestUseCase.call(NoParams());

    result.fold(
          (failure) => emit(
          FetchReceivedFriendRequestFailureState(mapFailureToMessage(failure))),
          (data) => emit(FetchReceivedFriendRequestSuccessState(data: data)),
    );
  }

  Future<void> _fetchReceivedGroup(FetchReceivedGroupInviteEvent event, Emitter emit) async {
    emit(FetchReceivedGroupInviteLoadingState());

    final result = await _getReceivedGroupInviteUseCase.call(NoParams());

    result.fold(
          (failure) => emit(FetchReceivedGroupInviteFailureState(mapFailureToMessage(failure))),
          (success) => emit(FetchReceivedGroupInviteSuccessState(data: success)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE NotificationBloc =====");
    return super.close();
  }
}
