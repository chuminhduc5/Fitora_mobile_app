import 'package:equatable/equatable.dart';

class ManagedGroupEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int privacy;
  final bool requirePostApproval;
  final String coverImageUrl;
  final String avatarUrl;
  final int status;
  final int memberCount;

  const ManagedGroupEntity({
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        description,
        privacy,
        requirePostApproval,
        coverImageUrl,
        avatarUrl,
        status,
        memberCount,
      ];
}
