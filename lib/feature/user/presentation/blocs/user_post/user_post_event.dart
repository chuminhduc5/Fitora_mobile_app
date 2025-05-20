part of 'user_post_bloc.dart';

@immutable
abstract class UserPostEvent extends Equatable {
  const UserPostEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserPostEvent extends UserPostEvent {
  final String userId;
  const FetchUserPostEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
