import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/received_group_invite_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Status { none, accept, deleted }

class ReceivedGroupInviteCardWidget extends StatefulWidget {
  final ReceivedGroupInviteEntity groupInvite;
  final Function()? onTap;

  // final void Function(String) acceptGroupInvite;
  // final void Function(String) deleteGroupInvite;
  // final bool? isAccept;
  // final bool? isDelete;
  const ReceivedGroupInviteCardWidget({
    super.key,
    required this.groupInvite,
    this.onTap,
    // required this.acceptGroupInvite,
    // required this.deleteGroupInvite,
    // this.isAccept = false,
    // this.isDelete = false,
  });

  @override
  State<ReceivedGroupInviteCardWidget> createState() =>
      _ReceivedGroupInviteCardWidgetState();
}

class _ReceivedGroupInviteCardWidgetState
    extends State<ReceivedGroupInviteCardWidget> {
  late final String groupId;
  Status status = Status.none;

  @override
  void initState() {
    groupId = widget.groupInvite.groupId;
    super.initState();
  }

  void _acceptGroup(BuildContext context) {
    logg.i("Accept group invite with groupId: $groupId}");
    context.read<GroupBloc>().add(AcceptGroupInviteEvent(id: groupId));
  }
  void _deleteGroup(BuildContext context) {
    logg.i("Delete group invite with groupId: $groupId");
    context.read<GroupBloc>().add(DeleteGroupInviteEvent(id: groupId));
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAvatarWidget(imagePath: widget.groupInvite.groupImageUrl, size: 80),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.groupInvite.senderName} đã mời bạn tham gia nhóm ${widget.groupInvite.groupName}",
                    softWrap: true,
                    maxLines: 2,
                  ),
                  if (status == Status.accept) ...[
                    Text("Bạn đã tham gia nhóm ${widget.groupInvite.groupName}"),
                    const SizedBox(height: 10),
                  ],
                  if (status == Status.deleted) ...[
                    const Text('Đã xóa lời mời tham gia nhóm'),
                    const SizedBox(height: 10),
                  ],
                  if (status != Status.accept && status != Status.deleted) ...[
                    Row(
                      children: [
                        BlocConsumer<GroupBloc, GroupState>(
                          listener: (context, state) {
                            if (state is AcceptGroupInviteFailureState) {
                              AppDisplayMessage.error(context, state.message);
                            } else if (state is AcceptGroupInviteSuccessState) {
                              context
                                  .read<GroupBloc>()
                                  .add(AcceptGroupInviteEvent(id: groupId));
                              logg.i("Đã gửi lời mời kết bạn");
                              setState(() {
                                status = Status.accept;
                              });
                            }
                          },
                          builder: (context, state) {
                            if (state is AcceptGroupInviteLoadingState) {
                              return const AppLoadingWidget();
                            }
                            return SizedBox(
                              width: 120,
                              child: AppButtonWidget(
                                onPressed: () {
                                  _acceptGroup(context);
                                  setState(() {
                                    status = Status.accept;
                                  });
                                },
                                title: "Chấp nhận",
                                bgColor: AppColors.bgPink,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 120,
                          child: AppButtonWidget(
                            onPressed: () {
                              _deleteGroup(context);
                              setState(() {
                                status = Status.deleted;
                              });
                            },
                            title: "Xóa",
                            bgColor: Colors.grey[200]!,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
