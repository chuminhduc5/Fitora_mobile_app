part of 'interact_bloc.dart';

@immutable
abstract class InteractEvent extends Equatable {
  const InteractEvent();

  @override
  List<Object?> get props => [];
}

class InteractPostEvent extends InteractEvent {
  final String userId;
  final String postId;
  final int voteType;

  const InteractPostEvent({
    required this.userId,
    required this.postId,
    required this.voteType,
  });

  @override
  List<Object?> get props => [userId, postId, voteType];
}

class InteractCommentEvent extends InteractEvent {
  final String userId;
  final String commentId;
  final int voteType;

  const InteractCommentEvent({
    required this.userId,
    required this.commentId,
    required this.voteType,
  });

  @override
  List<Object?> get props => [userId, commentId, voteType];
}