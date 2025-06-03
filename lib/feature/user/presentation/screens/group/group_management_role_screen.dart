import 'dart:io';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_article_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_event_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_introduction_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_member_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/group/group_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class GroupManagementRoleScreen extends StatefulWidget {
  final GroupResponseEntity groupInfo;

  const GroupManagementRoleScreen({super.key, required this.groupInfo});

  @override
  State<GroupManagementRoleScreen> createState() =>
      _GroupManagementRoleScreenState();
}

class _GroupManagementRoleScreenState extends State<GroupManagementRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: false,
          expandedHeight: kToolbarHeight,
          backgroundColor: AppColors.bgWhite,
          elevation: 0,
          // title: _showTitle
          //     ? Text(
          //         "${profile.userInfo.firstName} ${profile.userInfo.lastName}",
          //       )
          //     : null,
          // centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              color: AppColors.bgWhite,
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                if (value == 'setting') {

                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'setting',
                  child: Row(
                    children: [
                      Icon(Icons.settings, size: 20),
                      SizedBox(width: 3),
                      Text(
                        'Cài đặt',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroupBackgroundWidget(
                  imagePath: widget.groupInfo.group.avatarUrl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  widget.groupInfo.group.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Nhóm Riêng tư · ${widget.groupInfo.group.memberCount} thành viên",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FTabs(
                style: FTabsStyle(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  indicatorSize: FTabBarIndicatorSize.tab,
                  decoration: const BoxDecoration(color: AppColors.bgWhite),
                  selectedLabelTextStyle: const TextStyle(
                    color: AppColors.bgPink,
                  ),
                  unselectedLabelTextStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  indicatorDecoration: const BoxDecoration(
                      // color: AppColors.bgPink,
                      // border: Border.all(color: AppColors.bgPink),
                      // borderRadius: BorderRadius.circular(50),
                      ),
                  focusedOutlineStyle: FFocusedOutlineStyle(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                tabs: [
                  FTabEntry(
                    label: const Text("Giới thiệu"),
                    content: Container(
                      width: double.infinity,
                      child:
                          GroupIntroductionScreen(groupInfo: widget.groupInfo),
                    ),
                  ),
                  FTabEntry(
                    label: const Text("Bài viết"),
                    content: Container(
                      width: double.infinity,
                      child: const GroupArticleScreen(),
                    ),
                  ),
                  FTabEntry(
                      label: const Text("Thành viên"),
                      content: Container(
                        width: double.infinity,
                        child: const GroupMemberScreen(),
                      )),
                  FTabEntry(
                      label: const Text("Sự kiện"),
                      content: Container(
                        width: double.infinity,
                        child: const GroupEventScreen(),
                      )),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
