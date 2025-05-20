class InviteNewMembersRequest {
  final String groupId;
  final List<String> receiverUserIds;

  const InviteNewMembersRequest({
    required this.groupId,
    required this.receiverUserIds,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "groupId": groupId,
      "receiverUserIds": receiverUserIds,
    };
  }
}
