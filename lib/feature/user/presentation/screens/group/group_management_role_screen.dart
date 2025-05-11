import 'dart:io';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_article_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_event_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_introduction_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_member_screen.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class GroupManagementRoleScreen extends StatefulWidget {
  final GroupResponseEntity groupInfo;
  const GroupManagementRoleScreen({super.key, required this.groupInfo});

  @override
  State<GroupManagementRoleScreen> createState() => _GroupManagementRoleScreenState();
}

class _GroupManagementRoleScreenState extends State<GroupManagementRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.file(
                  File(widget.groupInfo.group.avatarUrl),
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      child: const GroupIntroductionScreen(),
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
