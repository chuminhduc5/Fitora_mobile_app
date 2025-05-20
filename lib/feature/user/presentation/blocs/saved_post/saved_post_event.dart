part of 'saved_post_bloc.dart';

@immutable
abstract class SavedPostEvent extends Equatable {
  const SavedPostEvent();

  @override
  List<Object?> get props => [];
}

class FetchSavedPostEvent extends SavedPostEvent {}
