import 'dart:io';

import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/group/group_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class GroupMemberRoleScreen extends StatefulWidget {
  final GroupResponseEntity groupInfo;

  const GroupMemberRoleScreen({super.key, required this.groupInfo});

  @override
  State<GroupMemberRoleScreen> createState() => _GroupMemberRoleScreenState();
}

class _GroupMemberRoleScreenState extends State<GroupMemberRoleScreen> {
  int selectedIndex = 0;
  final List<String> tags = [
    'Dành cho bạn',
    'Đáng chú ý',
    'Bài viết',
    'Khám phá',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroupBackgroundWidget(imagePath: widget.groupInfo.group.avatarUrl),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.groupInfo.group.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (widget.groupInfo.group.privacy == 1)
                          const Icon(Icons.public, size: 16, color: Colors.grey),
                        if (widget.groupInfo.group.privacy == 2)
                          const Icon(Icons.lock, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          "Nhóm Riêng tư · ${widget.groupInfo.group.memberCount} thành viên",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButtonWidget(
                        onPressed: () {},
                        title: "Đã tham gia",
                        color: AppColors.black,
                        bgColor: AppColors.bgGray,
                        prefixIcon: const Icon(
                          Icons.group,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButtonWidget(
                        onPressed: () {
                          logg.i("Mời bạn bè");
                          context.pushNamed(
                            AppRoute.inviteFriendGroup.name,
                            extra: widget.groupInfo.group.id,
                          );
                        },
                        title: "Mời",
                        bgColor: AppColors.bgPink,
                        prefixIcon: const Icon(
                          Icons.person_add_alt_1,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tags.length, (index) {
                      final isSelected = index == selectedIndex;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          showCheckmark: false,
                          label: Text(tags[index]),
                          selected: isSelected,
                          selectedColor: Colors.grey[200],
                          onSelected: (_) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.black : Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    AppAvatarWidget(
                      imagePath: widget.groupInfo.groupMember.profilePictureUrl,
                      size: 45,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: FTextField(
                        enabled: true,
                        hint: "Bạn đang nghĩ gì?",
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.none,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.image, color: Colors.green),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _postOption(Icons.face, "Cảm xúc"),
                      _postOption(Icons.poll, "Cuộc thăm dò"),
                      _postOption(Icons.visibility_off, "Bài viết ẩn danh"),
                    ],
                  ),
                ),
              ),

              Divider(),

              // Bài viết đầu tiên
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: _buildPost(),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _postOption(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700], size: 20),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPost() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            CircleAvatar(backgroundColor: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Huy Hoang Nguyen The",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text("19 thg 3, 2024 · ",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Icon(Icons.lock, size: 12, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.more_horiz)
          ],
        ),
        SizedBox(height: 12),

        // Nội dung bài viết
        Text(
          "THÔNG BÁO TUYỂN THÀNH VIÊN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("CỘNG ĐỒNG HỖ TRỢ HỌC TẬP VÀ LÀM VIỆC"),
        Text("• Đây là cộng đồng được tạo ra với mục tiêu..."),
        SizedBox(height: 12),

        // Footer
        Row(
          children: [
            Icon(Icons.thumb_up_alt, color: Colors.blue, size: 16),
            SizedBox(width: 4),
            Text("Đặng Giang và 5"),
            SizedBox(width: 12),
            Text("5 bình luận"),
            SizedBox(width: 12),
            Text("43 người đã xem"),
          ],
        )
      ],
    );
  }
}
