part of 'users_bloc.dart';

@immutable
abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsersEvent extends UsersEvent {}