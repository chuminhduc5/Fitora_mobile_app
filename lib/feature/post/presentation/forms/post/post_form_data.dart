import 'package:equatable/equatable.dart';

class PostFormData extends Equatable {
  final String content;
  final String mediaUrl;
  final int privacy;
  final String? groupId;
  final String? categoryId;
  final bool isValid;

  const PostFormData({
    required this.content,
    required this.mediaUrl,
    required this.privacy,
    this.groupId,
    this.categoryId,
    required this.isValid,
  });

  @override
  List<Object?> get props => [content, mediaUrl, privacy, groupId];

  PostFormData copyWith({
    String? content,
    String? mediaUrl,
    int? privacy,
    String? groupId,
    String? categoryId,
    bool? isValid,
  }) {
    return PostFormData(
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      privacy: privacy ?? this.privacy,
      groupId: groupId ?? this.groupId,
      categoryId: categoryId ?? this.categoryId,
      isValid: isValid ?? this.isValid,
    );
  }
}
