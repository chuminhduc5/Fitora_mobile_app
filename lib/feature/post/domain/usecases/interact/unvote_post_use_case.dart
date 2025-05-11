import 'package:equatable/equatable.dart';

class Params extends Equatable {
  final String userId;
  final String postId;
  final int voteType;

  const Params({
    required this.userId,
    required this.postId,
    required this.voteType,
  });

  @override
  List<Object?> get props => [userId, postId, voteType];
}
