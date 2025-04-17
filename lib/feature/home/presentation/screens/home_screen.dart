import 'dart:async';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/left_drawer/left_drawer.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer.dart';
import 'package:fitora_mobile_app/common/widgets/post/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/network/network_checker.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/home/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/home/presentation/widgets/newsfeed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _articleList = [
    {
      "avatar": AppImages.avatar,
      "author": "Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "new",
      "image": AppImages.bgImage,
      "description": "",
      "time": "2025-03-05T22:47:43.128427+07:00",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "content": "test",
      "image": AppImages.bgImageSecond,
      "description": "",
      "time": "2025-03-05T22:47:43.128427+07:00",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "content": "test",
      "image": AppImages.bgImageThird,
      "description": "",
      "time": "2025-03-05T22:47:43.128427+07:00",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Minh Đức",
      "content": "Test đăng bài",
      "image": "",
      "description": "",
      "time": "2025-03-05T22:47:43.128427+07:00",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
  ];

  int selectedIndex = 0;

  String selectedCategory = 'Tất cả';
  final List<String> categories = [
    'Tất cả',
    'BlockChain',
    'AI',
    'Web',
    'Mobile',
  ];

  final List<Color> categoriesColor = [
    Colors.white,
    Colors.lightBlueAccent,
    Colors.blue[200]!,
    Colors.yellow[200]!,
    Colors.green[200]!,
  ];

  final List<Widget> articlesByCategory = [];

  late NewsfeedBloc _newsfeedBloc;
  late Timer _timer;

  @override
  void initState() {
    _newsfeedBloc = getIt<NewsfeedBloc>()..add(FetchNewsfeedEvent());
    final network = getIt<NetworkChecker>();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      //_checkInternetConnection(network);
    });
    super.initState();
  }

  // void _checkInternetConnection(NetworkChecker network) {
  //   network.checkIsConnected.then((event) {
  //     if (network.getIsConnected != event) {
  //       if (event && !network.getIsConnected) {
  //         AppDisplayMessage.success(context, "Kết nối mạng phục hồi");
  //         _newsfeedBloc.add(FetchNewsfeedEvent());
  //       } else {
  //         AppDisplayMessage.info(context, "Kết nối mạng bị ngắt");
  //       }
  //     }
  //     network.setIsConnected = event;
  //   });
  // }

  void _checkInternetConnection(NetworkChecker network) async {
    bool isConnected = await network.checkIsConnected;

    if (network.getIsConnected != isConnected) {
      network.setIsConnected = isConnected;

      if (isConnected) {
        AppDisplayMessage.success(context, "Kết nối mạng phục hồi");
        _newsfeedBloc.add(FetchNewsfeedEvent());
      } else {
        AppDisplayMessage.info(context, "Kết nối mạng bị ngắt");
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _newsfeedBloc),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthSignOutLoadingState) {
          showDialog(
            context: context,
            builder: (_) => const AppLoadingWidget(),
          );
        } else if (state is AuthSignOutSuccessState) {
          context.goNamed(AppRoute.signIn.name);
          AppDisplayMessage.success(context, state.message);
        } else if (state is AuthSignOutFailureState) {
          context.pop();
          AppDisplayMessage.error(context, state.message);
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.bgWhite,
          appBar: AppBar(
            backgroundColor: AppColors.bgWhite,
            title: const Text(
              'Fitora',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.bgPink,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  context.goNamed(AppRoute.search.name);
                },
                icon: const Icon(Icons.search_outlined),
              ),
              IconButton(
                onPressed: () {
                  context.goNamed(AppRoute.notification.name);
                },
                // icon: const Icon(Icons.notifications),
                icon: Badge.count(
                  count: 1,
                  child: const Icon(Icons.notifications),
                ),
              ),
            ],
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                color: Colors.grey[200],
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      final isSelected = index == selectedIndex;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(categories[index]),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          selectedColor: categoriesColor[index],
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
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.bgPink,
                  backgroundColor: AppColors.bgWhite,
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    context.read<NewsfeedBloc>().add(FetchNewsfeedEvent());
                  },
                  child: NewsfeedWidget(selectedCategory: categories[selectedIndex]),
                ),
              ),
              // Expanded(
              //   child: CustomScrollView(
              //     slivers: [
              //       SliverList(
              //         delegate: SliverChildBuilderDelegate(
              //           (context, index) {
              //             final article = _articleList[index];
              //             return NewsfeedPostWidget(
              //               avatar: article['avatar'],
              //               author: article['author'],
              //               content: article['content'],
              //               images: article["image"],
              //               favourite: article['favourite'],
              //               comment: article['comment'],
              //               share: article['share'],
              //               //time: article['time'],
              //             );
              //           },
              //           childCount: _articleList.length,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
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

  // Widget buildAllArticle() {
  //   return CustomScrollView(
  //     slivers: [
  //       SliverList(
  //         delegate: SliverChildBuilderDelegate(
  //           (context, index) {
  //             final article = _articleList[index];
  //             return NewsfeedPostWidget(
  //               avatar: article['avatar'],
  //               author: article['author'],
  //               content: article['content'],
  //               images: article["image"],
  //               favourite: article['favourite'],
  //               comment: article['comment'],
  //               share: article['share'],
  //               //time: article['time'],
  //             );
  //           },
  //           childCount: _articleList.length,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
