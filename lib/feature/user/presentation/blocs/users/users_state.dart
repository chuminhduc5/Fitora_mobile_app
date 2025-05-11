part of 'users_bloc.dart';

@immutable
abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

class FetchUsersInitialState extends UsersState {}

class FetchUsersLoadingState extends UsersState {}

class FetchUsersSuccessState extends UsersState {
  final List<UserEntity> data;
  const FetchUsersSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchUsersFailureState extends UsersState {
  final String message;
  const FetchUsersFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
