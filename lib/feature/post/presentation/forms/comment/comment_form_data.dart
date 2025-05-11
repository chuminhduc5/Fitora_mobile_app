import 'package:equatable/equatable.dart';

class CommentFormData extends Equatable {
  final String postId;
  final String? parentCommentId;
  final String content;
  final String? mediaUrl;

  const CommentFormData({
    required this.postId,
    this.parentCommentId,
    required this.content,
    this.mediaUrl,
  });

  @override
  List<Object?> get props => [
        postId,
        parentCommentId,
        content,
        mediaUrl,
      ];

  CommentFormData copyWith({
    String? postId,
    String? parentCommentId,
    String? content,
    String? mediaUrl,
  }) {
    return CommentFormData(
      postId: postId ?? this.postId,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
    );
  }
}
