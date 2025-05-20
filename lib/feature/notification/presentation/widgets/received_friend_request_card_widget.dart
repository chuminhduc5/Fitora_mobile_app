import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/friend_request_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/friend/friend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Status { none, accept, deleted }

class ReceivedFriendRequestCardWidget extends StatefulWidget {
  final FriendRequestEntity friend;
  final Function()? onTap;
  //final void Function(String) onPressed;
  // final bool isActionInvite;

  const ReceivedFriendRequestCardWidget({
    super.key,
    required this.friend,
    this.onTap,
    //required this.onPressed,
    // required this.isActionInvite,
  });

  @override
  State<ReceivedFriendRequestCardWidget> createState() =>
      _ReceivedFriendRequestCardWidgetState();
}

class _ReceivedFriendRequestCardWidgetState
    extends State<ReceivedFriendRequestCardWidget> {
  late final String friendId;
  Status status = Status.none;

  @override
  void initState() {
    friendId = widget.friend.senderId;
    super.initState();
  }

  void _acceptFriend(BuildContext context) {
    // final userId = widget.friend.senderId;
    print("Call Accept Friend with userId: $friendId");
    context.read<FriendBloc>().add(AcceptFriendEvent(friendId));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAvatarWidget(imagePath: widget.friend.senderImageUrl, size: 75),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.friend.senderName} đã gửi cho bạn lời mời kết bạn',
                    softWrap: true,
                    maxLines: 2,
                  ),
                  //const SizedBox(height: 4),
                  Text(
                    "${widget.friend.createDate}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  if (status == Status.accept) ...[
                    Text("Bạn và ${widget.friend.senderName} đã là bạn bè"),
                    const SizedBox(height: 10),
                  ],
                  if (status == Status.deleted) ...[
                    const Text('Đã xóa người dùng khỏi danh sách'),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 4),
                  if (status != Status.accept && status != Status.deleted) ...[
                    Row(
                      children: [
                        BlocConsumer<FriendBloc, FriendState>(
                          listener: (context, state) {
                            if (state is AddFriendFailureState) {
                              AppDisplayMessage.error(context, state.message);
                            } else if (state is AddFriendSuccessState) {
                              context
                                  .read<FriendBloc>()
                                  .add(FetchRecommendUserEvent());
                              logg.i("Đã gửi lời mời kết bạn");
                              setState(() {
                                status = Status.accept;
                              });
                            }
                          },
                          builder: (context, state) {
                            if (state is AddFriendLoadingState) {
                              return const AppLoadingWidget();
                            }
                            return SizedBox(
                              width: 120,
                              height: 40,
                              child: AppButtonWidget(
                                onPressed: () {
                                  _acceptFriend(context);
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
                          height: 40,
                          child: AppButtonWidget(
                            onPressed: () {
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
