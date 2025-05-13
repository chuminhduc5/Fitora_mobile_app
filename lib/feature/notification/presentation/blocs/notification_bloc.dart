import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
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
    on<FetchNotificationEvent>(_fetchNotification);
  }

  // Gọi usecase lấy lời mời kết bạn
  Future<Either<Failure, List<FriendRequestEntity>>> _fetchFriendRequests() {
    return _getReceivedFriendRequestUseCase(NoParams());
  }

  // Gọi usecase lấy lời mời nhóm
  Future<Either<Failure, List<ReceivedGroupInviteEntity>>> _fetchGroupInvites() {
    return _getReceivedGroupInviteUseCase(NoParams());
  }

  // Xử lý khi nhận FetchNotificationEvent
  Future _fetchNotification(FetchNotificationEvent event, Emitter emit) async {
    emit(FetchNotificationLoadingState());

    final friendResultFuture = _fetchFriendRequests();
    final groupResultFuture = _fetchGroupInvites();

    final friendResult = await friendResultFuture;
    final groupResult = await groupResultFuture;

    final isFriendSuccess = friendResult.isRight();
    final isGroupSuccess = groupResult.isRight();

    if (isFriendSuccess && isGroupSuccess) {
      emit(FetchNotificationSuccessState(
        friendRequests: friendResult.getOrElse(() => []),
        groupInvites: groupResult.getOrElse(() => []),
      ));
    } else {
      final errorMessage = friendResult.fold(
            (f) => mapFailureToMessage(f),
            (_) => groupResult.fold(
              (f) => mapFailureToMessage(f),
              (_) => 'Unknown error',
        ),
      );
      emit(FetchNotificationFailureState(errorMessage));
    }
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE NotificationBloc =====");
    return super.close();
  }
}
