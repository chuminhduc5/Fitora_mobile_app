part of 'category_form_bloc.dart';

@immutable
abstract class CategoryFormEvent extends Equatable {
  const CategoryFormEvent();

  @override
  List<Object?> get props => [];
}

class CategoryLoadDataEvent extends CategoryFormEvent {
  final CategoryFormData params;

  const CategoryLoadDataEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class CategoryNameChangedEvent extends CategoryFormEvent {
  final String name;

  const CategoryNameChangedEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class CategorySlugChangedEvent extends CategoryFormEvent {
  final String slug;

  const CategorySlugChangedEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class CategoryDescriptionChangedEvent extends CategoryFormEvent {
  final String description;

  const CategoryDescriptionChangedEvent(this.description);

  @override
  List<Object?> get props => [description];
}

class CategoryParentIdChangedEvent extends CategoryFormEvent {
  final String? parentId;

  const CategoryParentIdChangedEvent(this.parentId);

  @override
  List<Object?> get props => [parentId];
}
