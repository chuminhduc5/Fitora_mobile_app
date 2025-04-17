import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/friends/data/models/recommend_user_model.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/friend_request_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/entities/recommend_user_entity.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/accept_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/add_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/delete_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/get_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/get_received_friend_request_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/get_recommend_user_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/get_sent_friend_request_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/unfriend_use_case.dart';
import 'package:meta/meta.dart';

part 'friend_event.dart';

part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final AddFriendUseCase _addFriendUseCase;
  final AcceptFriendUseCase _acceptFriendUseCase;
  final DeleteFriendUseCase _deleteFriendUseCase;
  final UnfriendUseCase _unfriendUseCase;
  final GetFriendUseCase _getFriendUseCase;
  final GetSentFriendRequestUseCase _getSentFriendRequestUseCase;
  final GetReceivedFriendRequestUseCase _getReceivedFriendRequestUseCase;
  final GetRecommendUserUseCase _getRecommendUserUseCase;

  FriendBloc(
      this._addFriendUseCase,
      this._acceptFriendUseCase,
      this._deleteFriendUseCase,
      this._unfriendUseCase,
      this._getFriendUseCase,
      this._getSentFriendRequestUseCase,
      this._getReceivedFriendRequestUseCase,
      this._getRecommendUserUseCase)
      : super(FriendInitialState()) {
    on<AddFriendEvent>(_addFriend);
    on<AcceptFriendEvent>(_acceptFriend);
    on<DeleteFriendEvent>(_deleteFriend);
    on<UnfriendEvent>(_unfriend);
    on<FetchFriendEvent>(_fetchFriend);
    on<FetchSentFriendRequestEvent>(_fetchSentFriendRequest);
    on<FetchReceivedFriendRequestEvent>(_fetchReceivedFriendRequest);
    on<FetchRecommendUserEvent>(_fetchRecommendUser);
  }

  Future<void> _addFriend(AddFriendEvent event, Emitter emit) async {
    emit(AddFriendLoadingState());

    final result = await _addFriendUseCase.call(event.userId);

    result.fold(
      (failure) => emit(AddFriendFailureState(mapFailureToMessage(failure))),
      (success) => emit(AddFriendSuccessState()),
    );
  }

  Future<void> _acceptFriend(AcceptFriendEvent event, Emitter emit) async {
    emit(AcceptFriendLoadingState());

    final result = await _acceptFriendUseCase.call(event.userId);

    result.fold(
      (failure) => emit(AcceptFriendFailureState(mapFailureToMessage(failure))),
      (success) => emit(AcceptFriendSuccessState()),
    );
  }

  Future<void> _deleteFriend(DeleteFriendEvent event, Emitter emit) async {
    emit(DeleteFriendLoadingState());

    final result = await _deleteFriendUseCase.call(event.userId);

    result.fold(
      (failure) => emit(DeleteFriendFailureState(mapFailureToMessage(failure))),
      (success) => emit(DeleteFriendSuccessState()),
    );
  }

  Future<void> _unfriend(UnfriendEvent event, Emitter emit) async {
    emit(UnfriendLoadingState());

    final result = await _unfriendUseCase.call(event.userId);

    result.fold(
      (failure) => emit(UnfriendFailureState(mapFailureToMessage(failure))),
      (success) => emit(UnfriendSuccessState()),
    );
  }

  Future _fetchFriend(FetchFriendEvent event, Emitter emit) async {
    emit(FetchFriendLoadingState());

    final result = await _getFriendUseCase.call(NoParams());

    result.fold(
      (failure) => emit(FetchFriendFailureState(mapFailureToMessage(failure))),
      (data) => emit(FetchFriendSuccessState(data: data)),
    );
  }

  Future _fetchSentFriendRequest(
      FetchSentFriendRequestEvent event, Emitter emit) async {
    emit(FetchSentFriendRequestLoadingState());

    final result = await _getSentFriendRequestUseCase.call(NoParams());

    result.fold(
      (failure) => emit(
          FetchSentFriendRequestFailureState(mapFailureToMessage(failure))),
      (data) => emit(FetchSentFriendRequestSuccessState(data: data)),
    );
  }

  Future _fetchReceivedFriendRequest(
      FetchReceivedFriendRequestEvent event, Emitter emit) async {
    emit(FetchReceivedFriendRequestLoadingState());

    final result = await _getReceivedFriendRequestUseCase.call(NoParams());

    result.fold(
      (failure) => emit(
          FetchReceivedFriendRequestFailureState(mapFailureToMessage(failure))),
      (data) => emit(FetchReceivedFriendRequestSuccessState(data: data)),
    );
  }

  Future _fetchRecommendUser(
      FetchRecommendUserEvent event, Emitter emit) async {
    emit(FetchRecommendUserLoadingState());

    final result = await _getRecommendUserUseCase.call(NoParams());

    result.fold(
      (failure) => emit(FetchRecommendUserFailureState(mapFailureToMessage(failure))),
      (data) => emit(FetchRecommendUserSuccessState(users: data)),
    );
  }
}
