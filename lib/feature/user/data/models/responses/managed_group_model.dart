class ManagedGroupModel {
  final String id;
  final String name;
  final String description;
  final int privacy;
  final bool requirePostApproval;
  final String? coverImageUrl;
  final String avatarUrl;
  final int status;
  final int memberCount;

  const ManagedGroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.privacy,
    required this.requirePostApproval,
    required this.coverImageUrl,
    required this.avatarUrl,
    required this.status,
    required this.memberCount,
  });

  factory ManagedGroupModel.fromJson(Map<String, dynamic> json) {
    return ManagedGroupModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      privacy: json['privacy'] as int,
      requirePostApproval: json['requirePostApproval'] as bool,
      coverImageUrl: json['coverImageUrl'] ?? "",
      avatarUrl: json['avatarUrl'] ?? "",
      status: json['status'] as int,
      memberCount: json['memberCount'] as int,
    );
  }
}
