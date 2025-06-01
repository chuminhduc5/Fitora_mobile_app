part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CreateCategoryLoadingState extends CategoryState {}

class CreateCategorySuccessState extends CategoryState {}

class CreateCategoryFailureState extends CategoryState {
  final String message;

  const CreateCategoryFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetCategoryByIdLoadingState extends CategoryState {}

class GetCategoryByIdSuccessState extends CategoryState {
  final CategoryEntity category;

  const GetCategoryByIdSuccessState({required this.category});

  @override
  List<Object?> get props => [category];
}

class GetCategoryByIdFailureState extends CategoryState {
  final String message;

  const GetCategoryByIdFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FollowCategoryLoadingState extends CategoryState {}

class FollowCategorySuccessState extends CategoryState {}

class FollowCategoryFailureState extends CategoryState {
  final String message;

  const FollowCategoryFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class UnfollowCategoryLoadingState extends CategoryState {}

class UnfollowCategorySuccessState extends CategoryState {}

class UnfollowCategoryFailureState extends CategoryState {
  final String message;

  const UnfollowCategoryFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchCategoryFollowedLoadingState extends CategoryState {}

class FetchCategoryFollowedSuccessState extends CategoryState {
  final List<CategoryEntity> categories;

  const FetchCategoryFollowedSuccessState({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class FetchCategoryFollowedFailureState extends CategoryState {
  final String message;

  const FetchCategoryFollowedFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class FetchCategoryTrendingLoadingState extends CategoryState {}

class FetchCategoryTrendingSuccessState extends CategoryState {
  final List<CategoryEntity> categories;

  const FetchCategoryTrendingSuccessState({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class FetchCategoryTrendingFailureState extends CategoryState {
  final String message;

  const FetchCategoryTrendingFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
