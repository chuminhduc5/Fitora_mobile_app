part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class CreateCategoryEvent extends CategoryEvent {
  final CreateCategoryFormData params;
  const CreateCategoryEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class FetchCategoryByIdEvent extends CategoryEvent {
  final String id;
  const FetchCategoryByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FollowCategoryEvent extends CategoryEvent {
  final String id;
  const FollowCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UnfollowCategoryEvent extends CategoryEvent {
  final String id;
  const UnfollowCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchCategoryFollowedEvent extends CategoryEvent {}

class FetchCategoryTrendingEvent extends CategoryEvent {}
