import 'package:equatable/equatable.dart';

class CreatePostFormData {
  final String content;
  final String mediaUrl;
  final int privacy;
  final String? groupId;
  final String? categoryId;

  const CreatePostFormData({
    required this.content,
    required this.mediaUrl,
    required this.privacy,
    this.groupId,
    this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
      'mediaUrl': mediaUrl,
      'privacy': privacy,
      'groupId': groupId,
      'categoryId': categoryId,
    };
  }
}
