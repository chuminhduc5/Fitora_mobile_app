class UpdateGroupRequest {
  final String id;
  final String name;
  final String description;
  final int privacy;
  final bool requirePostApproval;
  final String coverImageUrl;
  final String avatarUrl;

  const UpdateGroupRequest({
    required this.id,
    required this.name,
    required this.description,
    required this.privacy,
    required this.requirePostApproval,
    required this.coverImageUrl,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "privacy": privacy,
      "requirePostApproval": requirePostApproval,
      "coverImageUrl": coverImageUrl,
      "avatarUrl": avatarUrl,
    };
  }
}
