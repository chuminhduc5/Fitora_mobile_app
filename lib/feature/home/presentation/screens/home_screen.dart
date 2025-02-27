import 'dart:async';

import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/left_drawer/left_drawer.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer.dart';
import 'package:fitora_mobile_app/common/widgets/newsfeed/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/router/app_router.dart';
import 'package:fitora_mobile_app/core/network/network_checker.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/home/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsfeedBloc _newsfeedBloc;
  late Timer _timer;
  final List<Map<String, dynamic>> _articleList = [
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Bài viêt mới",
      "content": "",
      "image": [],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image": [AppImages.avatar],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image": [AppImages.avatar, AppImages.avatar],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image": [AppImages.avatar, AppImages.avatar, AppImages.avatar],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image": [
        AppImages.avatar,
        AppImages.avatar,
        AppImages.avatar,
        AppImages.avatar
      ],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
  ];

  @override
  void initState() {
    _newsfeedBloc = getIt<NewsfeedBloc>()..add(FetchNewsfeedEvent());
    final network = getIt<NetworkChecker>();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkInternetConnection(network);
    });
    super.initState();
  }

  void _checkInternetConnection(NetworkChecker network) {
    network.checkIsConnected.then((event) {
      if (network.getIsConnected != event) {
        if (event && !network.getIsConnected) {
          AppDisplayMessage.success(context, "Kết nối mạng phục hồi");
          _newsfeedBloc.add(FetchNewsfeedEvent());
        } else {
          AppDisplayMessage.info(context, "Kết nối mạng bị ngắt");
        }
      }
      network.setIsConnected = event;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // static const _pageSize = 10;
  // final PagingController<String?, PostEntity> _pagingController = PagingController(firstPageKey: null);
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _pagingController.addPageRequestListener((lastPostId) {
  //     _fetchPage(lastPostId);
  //   });
  // }
  //
  // Future<void> _fetchPage(String? lastPostId) async {
  //   try {
  //     final newPosts = await fetchPostsFromApi(lastPostId, _pageSize);
  //     final isLastPage = newPosts.length < _pageSize;
  //
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newPosts);
  //     } else {
  //       final nextPageKey = newPosts.last.id; // Cursor (ID bài viết cuối cùng)
  //       _pagingController.appendPage(newPosts, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _newsfeedBloc),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      child: BlocConsumer(listener: (context, state) {
        if (state is AuthSignOutLoadingState) {
          showDialog(
            context: context,
            builder: (_) => const AppLoadingWidget(),
          );
        } else if (state is AuthSignOutSuccessState) {
          appRouter.goNamed('/sign-in');
          AppDisplayMessage.success(context, state.message);
        } else if (state is AuthSignOutFailureState) {
          context.pop();
          AppDisplayMessage.error(context, state.message);
        }
      }, builder: (context, state) {
        if (state is FetchNewsfeedLoadingState) {
          return const AppLoadingWidget();
        } else if (state is FetchNewsfeedFailureState) {
          AppDisplayMessage.error(context, state.message);
        } else if (state is FetchNewsfeedSuccessState) {
          final newsfeeds = state.data;

          return Scaffold(
            drawer: leftDrawer(),
            endDrawer: rightDrawer(context),
            backgroundColor: AppColors.bgWhite,
            appBar: AppBar(
              backgroundColor: AppColors.bgPink,
              title: const Text(
                'Fitora',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          AppImages.avatar,
                          height: 33,
                          width: 33,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                })
              ],
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: RefreshIndicator(
              color: AppColors.bgPink,
              backgroundColor: AppColors.bgWhite,
              onRefresh: () {
                return Future.delayed(
                  const Duration(seconds: 1),
                ).then((value) =>
                    context.read<NewsfeedBloc>().add(FetchNewsfeedEvent()));
              },
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final newsfeed = newsfeeds[index];
                        //logger.i(article['image']);
                        return NewsfeedPostWidget(
                          avatar: newsfeed.mediaUrl,
                          author: newsfeed.userId,
                          content: newsfeed.content,
                          time: newsfeed.createAt,
                          favourite: newsfeed.privacy,
                          comment: newsfeed.commentsCount,
                          share: newsfeed.votesCount,
                        );
                      },
                      childCount: newsfeeds.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: const Column(
            children: <Widget>[],
          ),
        );
      },
    );
  }
}
