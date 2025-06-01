import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/category_entity.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/categories/create_category_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/categories/follow_category_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/categories/get_category_by_id_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/categories/get_category_followed_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/categories/get_category_trending_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/categories/unfollow_category_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/usecase_params.dart';
import 'package:fitora_mobile_app/feature/post/presentation/forms/category/create_category_form_data.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CreateCategoryUseCase _createCategoryUseCase;
  final GetCategoryByIdUseCase _getCategoryByIdUseCase;
  final FollowCategoryUseCase _followCategoryUseCase;
  final UnfollowCategoryUseCase _unfollowCategoryUseCase;
  final GetCategoryFollowedUseCase _fetchCategoryFollowedUseCase;
  final GetCategoryTrendingUseCase _fetchCategoryTrendingUseCase;
  CategoryBloc(
    this._createCategoryUseCase,
    this._getCategoryByIdUseCase,
    this._followCategoryUseCase,
    this._unfollowCategoryUseCase,
    this._fetchCategoryFollowedUseCase,
    this._fetchCategoryTrendingUseCase,
  ) : super(CategoryInitial()) {
    on<CreateCategoryEvent>(_createCategory);
    on<FetchCategoryByIdEvent>(_getCategoryById);
    on<FollowCategoryEvent>(_follow);
    on<UnfollowCategoryEvent>(_unfollow);
    on<FetchCategoryFollowedEvent>(_getFollowed);
    on<FetchCategoryTrendingEvent>(_getTrending);
  }

  Future _createCategory(CreateCategoryEvent event, Emitter emit) async {
    emit(CreateCategoryLoadingState());
    final result = await _createCategoryUseCase.call(CreateCategoryParams(
      name: event.params.name,
      slug: event.params.slug,
      description: event.params.description,
      parentId: event.params.parentId,
    ));
    result.fold(
      (failure) =>
          emit(CreateCategoryFailureState(mapFailureToMessage(failure))),
      (_) => emit(CreateCategorySuccessState()),
    );
  }

  Future _getCategoryById(FetchCategoryByIdEvent event, Emitter emit) async {
    emit(GetCategoryByIdLoadingState());
    final result = await _getCategoryByIdUseCase.call(event.id);
    result.fold(
      (failure) =>
          emit(GetCategoryByIdFailureState(mapFailureToMessage(failure))),
      (category) => emit(GetCategoryByIdSuccessState(category: category)),
    );
  }

  Future _follow(FollowCategoryEvent event, Emitter emit) async {
    emit(FollowCategoryLoadingState());
    final result = await _followCategoryUseCase.call(event.id);
    result.fold(
      (failure) =>
          emit(FollowCategoryFailureState(mapFailureToMessage(failure))),
      (_) => emit(FollowCategorySuccessState()),
    );
  }

  Future _unfollow(UnfollowCategoryEvent event, Emitter emit) async {
    emit(UnfollowCategoryLoadingState());
    final result = await _unfollowCategoryUseCase.call(event.id);
    result.fold(
      (failure) =>
          emit(UnfollowCategoryFailureState(mapFailureToMessage(failure))),
      (_) => emit(UnfollowCategorySuccessState()),
    );
  }

  Future _getFollowed(FetchCategoryFollowedEvent event, Emitter emit) async {
    emit(FetchCategoryFollowedLoadingState());
    final result = await _fetchCategoryFollowedUseCase.call(NoParams());
    result.fold(
      (failure) =>
          emit(FetchCategoryFollowedFailureState(mapFailureToMessage(failure))),
      (categories) =>
          emit(FetchCategoryFollowedSuccessState(categories: categories)),
    );
  }

  Future _getTrending(FetchCategoryTrendingEvent event, Emitter emit) async {
    emit(FetchCategoryFollowedLoadingState());
    final result = await _fetchCategoryTrendingUseCase.call(NoParams());
    result.fold(
      (failure) =>
          emit(FetchCategoryFollowedFailureState(mapFailureToMessage(failure))),
      (categories) =>
          emit(FetchCategoryFollowedSuccessState(categories: categories)),
    );
  }
}
