import 'package:equatable/equatable.dart';

class CreatePostFormData extends Equatable {
  final String content;
  final String mediaUrl;
  final int privacy;
  final String groupId;

  const CreatePostFormData({
    required this.content,
    required this.mediaUrl,
    required this.privacy,
    required this.groupId,
  });

  @override
  List<Object?> get props => [content, mediaUrl, privacy, groupId];

  CreatePostFormData copyWith({
    String? content,
    String? mediaUrl,
    int? privacy,
    String? groupId,
  }) {
    return CreatePostFormData(
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      privacy: privacy ?? this.privacy,
      groupId: groupId ?? this.groupId,
    );
  }
}
