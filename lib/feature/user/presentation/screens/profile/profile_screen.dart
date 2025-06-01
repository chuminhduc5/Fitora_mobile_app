import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/loader/user_skeleton_loading.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/profile/profile_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/user_post/user_post_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/users/users_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/user_friend_list_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/user_photo_list_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/profile/profile_info_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/user_post_list_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/user_video_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showTitle = false;
  late final String userId;
  late ProfileBloc _profileBloc;
  late UserPostBloc _userPostBloc;

  // @override
  // void initState() {
  //   _getUserId();
  //   _profileBloc = getIt<ProfileBloc>()..add(FetchProfileEvent());
  //   _userPostBloc = getIt<UserPostBloc>()..add(FetchUserPostEvent(userId: userId));
  //   super.initState();
  // }

  @override
  void initState() {
    _init();
    _profileBloc = getIt<ProfileBloc>()..add(FetchProfileEvent());
    super.initState();
  }

  Future<void> _init() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('userId')!;

    _userPostBloc = getIt<UserPostBloc>()
      ..add(FetchUserPostEvent(userId: userId));
  }

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(AuthSignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      //endDrawer: rightDrawer(context),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _profileBloc,
          ),
          BlocProvider(
            create: (context) => _userPostBloc,
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
            ).then(
              (value) => context.read<ProfileBloc>().add(
                    FetchProfileEvent(),
                  ),
            );
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                if (notification.metrics.pixels > 150) {
                  if (!_showTitle) setState(() => _showTitle = true);
                } else {
                  if (_showTitle) setState(() => _showTitle = false);
                }
              }
              return true;
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is FetchProfileLoadingState) {
                  //return const AppLoadingWidget();
                  return const UserSkeletonLoading();
                } else if (state is FetchProfileFailureState) {
                  return AppErrorWidget(state.message);
                } else if (state is FetchProfileSuccessState) {
                  final profile = state.data;
                  final userId = profile.userInfo.userId;
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        floating: false,
                        expandedHeight: kToolbarHeight,
                        backgroundColor: AppColors.bgWhite,
                        elevation: 0,
                        title: _showTitle
                            ? Text(
                                "${profile.userInfo.firstName} ${profile.userInfo.lastName}",
                              )
                            : null,
                        centerTitle: true,
                        actions: [
                          PopupMenuButton<String>(
                            padding: EdgeInsets.zero,
                            color: AppColors.bgWhite,
                            icon: const Icon(Icons.menu),
                            onSelected: (value) {
                              if (value == 'setting') {
                                context.pushNamed(AppRoute.setting.name);
                              } else if (value == 'logout') {
                                _logout(context);
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
                              PopupMenuItem(
                                value: 'logout',
                                child: BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthSignOutFailureState) {

                                    } else if (state is AuthSignOutSuccessState) {
                                      AppDisplayMessage.success(context, 'Đăng xuất thành công');
                                      context.goNamed(AppRoute.auth.name);
                                    }
                                  },
                                  builder: (context, state) {
                                    return const Row(
                                      children: [
                                        Icon(Icons.logout, size: 20),
                                        SizedBox(width: 3),
                                        Text(
                                          "Đăng xuất",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          child: Column(
                            children: [
                              ProfileInfoWidget(profile: profile),
                              FTabs(
                                style: FTabsStyle(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  indicatorSize: FTabBarIndicatorSize.tab,
                                  decoration: const BoxDecoration(
                                      color: AppColors.bgWhite),
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
                                tabs: [
                                  FTabEntry(
                                    label: const Text("Bài viết"),
                                    content: Container(
                                      width: double.infinity,
                                      constraints: const BoxConstraints(
                                        minHeight: 100,
                                      ),
                                      child: const UserPostListWidget(),
                                    ),
                                  ),
                                  FTabEntry(
                                    label: const Text("Ảnh"),
                                    content: Container(
                                      width: double.infinity,
                                      constraints: const BoxConstraints(
                                        minHeight: 100,
                                      ),
                                      child: const UserPhotoListWidget(),
                                    ),
                                  ),
                                  FTabEntry(
                                      label: const Text("Video"),
                                      content: Container(
                                        width: double.infinity,
                                        child: const UserVideoListWidget(),
                                      )),
                                  FTabEntry(
                                      label: const Text("Bạn bè"),
                                      content: Container(
                                        width: double.infinity,
                                        child: const UserFriendListWidget(),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInFoItem(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.pink),
        const SizedBox(width: 5),
        Text(text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _statItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildVerticalLine() {
    return const SizedBox(
      height: 25,
      child: VerticalDivider(
        thickness: 1,
        color: Colors.grey,
        width: 0,
      ),
    );
  }

  Widget _button(
      Function() onPressed, String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 14),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Widget _buildInterests() {
    List<String> interests = [
      "JavaScript",
      "Flutter",
      ".NET",
      "SQL Server",
      "MY SQL",
      "Web",
      "App"
    ];

    List<Color> backgroundColors = [
      Colors.purple.shade100,
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.yellow.shade100,
      Colors.orange.shade100,
      Colors.red.shade100,
      Colors.cyan.shade100
    ];

    List<Color> textColors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.yellow[800]!,
      Colors.orange[800]!,
      Colors.red[800]!,
      Colors.cyan[800]!
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(interests.length, (index) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColors[index],
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            interests[index],
            style: TextStyle(color: textColors[index], fontSize: 14),
          ),
        );
      }),
    );
  }
}
