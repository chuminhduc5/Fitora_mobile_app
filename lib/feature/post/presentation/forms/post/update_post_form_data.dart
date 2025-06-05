class UpdatePostFormData {
  final String content;
  final String mediaUrl;
  final int privacy;
  final bool isApproved;

  const UpdatePostFormData({
    required this.content,
    required this.mediaUrl,
    required this.privacy,
    required this.isApproved,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
      'mediaUrl': mediaUrl,
      'privacy': privacy,
      'isApproved': isApproved,
    };
  }
}
