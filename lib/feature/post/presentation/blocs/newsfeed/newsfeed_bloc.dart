import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_explore_feed_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_newsfeed_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_trending_feed_use_case.dart';
import 'package:meta/meta.dart';

part 'newsfeed_event.dart';

part 'newsfeed_state.dart';

class NewsfeedBloc extends Bloc<NewsfeedEvent, NewsfeedState> {
  final GetNewsfeedUseCase _getNewsfeedUseCase;
  final GetTrendingFeedUseCase _getTrendingFeedUseCase;
  final GetExploreFeedUseCase _getExploreFeedUseCase;

  NewsfeedBloc(
    this._getNewsfeedUseCase,
    this._getTrendingFeedUseCase,
    this._getExploreFeedUseCase,
  ) : super(NewsfeedInitialState()) {
    on<FetchNewsfeedEvent>(_fetchNewsfeed);
    on<FetchTrendingFeedEvent>(_fetchTrendingFeed);
    on<FetchExploreFeedEvent>(_fetchExploreFeed);
  }

  Future _fetchNewsfeed(FetchNewsfeedEvent event, Emitter emit) async {
    emit(FetchNewsfeedLoadingState());

    final result = await _getNewsfeedUseCase.call(NoParams());

    result.fold(
      (error) => emit(FetchNewsfeedFailureState(mapFailureToMessage(error))),
      (data) => emit(FetchNewsfeedSuccessState(data: data)),
    );
  }

  Future _fetchTrendingFeed(FetchTrendingFeedEvent event, Emitter emit) async {
    emit(FetchTrendingFeedLoadingState());

    final result = await _getTrendingFeedUseCase.call(NoParams());

    result.fold(
      (error) => emit(FetchTrendingFeedFailureState(mapFailureToMessage(error))),
      (data) => emit(FetchTrendingFeedSuccessState(data: data)),
    );
  }

  Future _fetchExploreFeed(FetchExploreFeedEvent event, Emitter emit) async {
    emit(FetchExploreFeedLoadingState());

    final result = await _getExploreFeedUseCase.call(NoParams());

    result.fold(
      (error) => emit(FetchExploreFeedFailureState(mapFailureToMessage(error))),
      (data) => emit(FetchExploreFeedSuccessState(data: data)),
    );
  }
}
