part of 'group_form_bloc.dart';

@immutable
abstract class GroupFormEvent extends Equatable {
  const GroupFormEvent();

  @override
  List<Object?> get props => [];
}

class GroupLoadDataEvent extends GroupFormEvent {
  final GroupFormData params;
  const GroupLoadDataEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class GroupNameChangeEvent extends GroupFormEvent {
  final String name;
  const GroupNameChangeEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class GroupDescriptionChangeEvent extends GroupFormEvent {
  final String description;
  const GroupDescriptionChangeEvent(this.description);

  @override
  List<Object?> get props => [description];
}

class GroupPrivacyChangeEvent extends GroupFormEvent {
  final int privacy;
  const GroupPrivacyChangeEvent(this.privacy);

  @override
  List<Object?> get props => [privacy];
}

class GroupRequirePostApprovalChangeEvent extends GroupFormEvent {
  final bool requirePostApproval;
  const GroupRequirePostApprovalChangeEvent(this.requirePostApproval);

  @override
  List<Object?> get props => [requirePostApproval];
}

class GroupCoverImageUrlChangeEvent extends GroupFormEvent {
  final String coverImageUrl;
  const GroupCoverImageUrlChangeEvent(this.coverImageUrl);

  @override
  List<Object?> get props => [coverImageUrl];
}

class GroupAvatarUrlChangeEvent extends GroupFormEvent {
  final String avatarUrl;
  const GroupAvatarUrlChangeEvent(this.avatarUrl);

  @override
  List<Object?> get props => [avatarUrl];
}