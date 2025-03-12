import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/widgets/friend_list_widget.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/widgets/user_info_widget.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/widgets/user_photo_list_widget.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/widgets/user_post_list_widget.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/widgets/user_video_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  bool _showUserName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.metrics.pixels > 150) {
              if (!_showUserName) setState(() => _showUserName = true);
            } else {
              if (_showUserName) setState(() => _showUserName = false);
            }
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: kToolbarHeight,
              backgroundColor: AppColors.bgWhite,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  context.goNamed(AppRoute.appView.name);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu, color: Colors.grey),
                ),
              ],
              title: _showUserName   ? const Text("Minh Đức") : null,
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const UserInfoWidget(username: "Minh Đức"),
                    FTabs(
                      style: FTabsStyle(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15),
                        indicatorSize: FTabBarIndicatorSize.tab,
                        decoration:
                        const BoxDecoration(color: AppColors.bgWhite),
                        selectedLabelTextStyle: const TextStyle(
                          color: AppColors.white,
                        ),
                        unselectedLabelTextStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        indicatorDecoration: BoxDecoration(
                          color: AppColors.bgPink,
                          border: Border.all(color: AppColors.bgPink),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedOutlineStyle: FFocusedOutlineStyle(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      tabs: const [
                        FTabEntry(
                          //label: const Icon(Icons.grid_view),
                            label: Text("Bài viết"),
                            content: UserPostListWidget()
                        ),
                        FTabEntry(
                          //label: const Icon(Icons.play_circle_outline),
                          label: Text("Ảnh"),
                          content: UserPhotoListWidget(),
                        ),
                        FTabEntry(
                          //label: const Icon(Icons.people_outline),
                            label: Text("Video"),
                            content: UserVideoListWidget()
                        ),
                        FTabEntry(
                          //label: const Icon(Icons.file_copy),
                          label: Text("Bạn bè"),
                          content: FriendListWidget(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
