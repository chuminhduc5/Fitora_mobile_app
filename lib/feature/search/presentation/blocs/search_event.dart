part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchUserEvent extends SearchEvent {
  final String keySearch;
  const SearchUserEvent({required this.keySearch});

  @override
  List<Object?> get props => [keySearch];
}

class SearchPostEvent extends SearchEvent {}
