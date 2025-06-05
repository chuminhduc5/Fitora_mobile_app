import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/friend/friend_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/user_post/user_post_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/user_friend_list_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/personal/user_info_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/profile/profile_info_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/user_photo_list_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/user_post_list_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/user_video_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class PersonalScreen extends StatefulWidget {
  final String userId;

  const PersonalScreen({super.key, required this.userId});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  bool _showTitle = false;
  late PersonalBloc _personalBloc;
  late UserPostBloc _userPostBloc;

  //late PersonalBloc _personal;

  @override
  void initState() {
    logg.i("Id Người dùng: ${widget.userId}");
    _personalBloc = getIt<PersonalBloc>()
      ..add(FetchPersonalEvent(userId: widget.userId));
    _userPostBloc = getIt<UserPostBloc>()
      ..add(FetchUserPostEvent(userId: widget.userId));
    super.initState();
  }

  void _addFriend(BuildContext context) {
    context.read<FriendBloc>().add(AddFriendEvent(widget.userId));
    logg.i('Kết bạn với người dùng: ${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _personalBloc,
        ),
        BlocProvider(
          create: (context) => _userPostBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
            ).then(
                  (value) =>
                  context.read<PersonalBloc>().add(
                    FetchPersonalEvent(userId: widget.userId),
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
            child: BlocBuilder<PersonalBloc, PersonalState>(
              builder: (context, state) {
                if (state is FetchPersonalLoadingState) {
                  return const AppLoadingWidget();
                } else if (state is FetchPersonalFailureState) {
                  return AppErrorWidget(state.message);
                } else if (state is FetchPersonalSuccessState) {
                  final profile = state.data;
                  final userId = profile.userInfo.userId;
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        floating: false,
                        expandedHeight: kToolbarHeight,
                        backgroundColor: AppColors.bgWhite,
                        elevation: 0,
                        actions: [
                          IconButton(
                            onPressed: () {
                              context.goNamed(AppRoute.auth.name);
                            },
                            icon: const Icon(Icons.menu, color: Colors.grey),
                          ),
                        ],
                        title: _showTitle
                            ? Text(
                          "${profile.userInfo.firstName} ${profile.userInfo
                              .lastName}",
                        )
                            : null,
                        centerTitle: true,
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          child: Column(
                            children: [
                              UserInfoWidget(
                                addFriend: () => _addFriend(context),
                                profile: profile,
                              ),
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
                                      child: UserPostListWidget(userInfo: profile,),
                                      //child: const UserPhotoListWidget(),
                                    ),
                                  ),
                                  FTabEntry(
                                    label: const Text("Ảnh"),
                                    content: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: const UserVideoListWidget(),
                                      )),
                                  FTabEntry(
                                      label: const Text("Bạn bè"),
                                      content: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
}
