import 'package:equatable/equatable.dart';

class GroupFormData extends Equatable {
  final String name;
  final String description;
  final int privacy;
  final bool requirePostApproval;
  final String coverImageUrl;
  final String avatarUrl;

  const GroupFormData({
    required this.name,
    required this.description,
    required this.privacy,
    required this.requirePostApproval,
    required this.coverImageUrl,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        privacy,
        requirePostApproval,
        coverImageUrl,
        avatarUrl,
      ];

  GroupFormData copyWith({
    String? name,
    String? description,
    int? privacy,
    bool? requirePostApproval,
    String? coverImageUrl,
    String? avatarUrl,
  }) {
    return GroupFormData(
      name: name ?? this.name,
      description: description ?? this.description,
      privacy: privacy ?? this.privacy,
      requirePostApproval: requirePostApproval ?? this.requirePostApproval,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
