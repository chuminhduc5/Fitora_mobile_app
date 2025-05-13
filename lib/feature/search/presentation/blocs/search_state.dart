part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchUserLoadingState extends SearchState {}

class SearchUserSuccessState extends SearchState {
  final List<UserEntity> data;
  const SearchUserSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class SearchUserFailureState extends SearchState {
  final String message;
  const SearchUserFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
