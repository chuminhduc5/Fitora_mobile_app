import 'dart:async';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/helper/mapper/user/user_profile_mapper.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/network/network_checker.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/interact/interact_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/newsfeed/newsfeed_widget.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String userId;
  UserProfileEntity? userInfo;
  int selectedIndex = 0;

  String selectedCategory = 'Tất cả';
  final List<String> categories = [
    'Tất cả',
    'Xu hướng',
    'Khám phá',
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
  late NewsfeedBloc _exploreFeedBloc;
  late NewsfeedBloc _trendingFeedBloc;
  late Timer _timer;
  final _hiveLocalStorage = HiveLocalStorage();

  // Future<void> _getUserId() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     userId = pref.getString('userId')!;
  //   });
  //   logger.i("UserId: $userId");
  // }

  @override
  void initState() {
    _getUserId();
    _loadUser();
    // _newsfeedBloc = getIt<NewsfeedBloc>()..add(FetchNewsfeedEvent());
    // _exploreFeedBloc = getIt<NewsfeedBloc>()..add(FetchExploreFeedEvent());
    _trendingFeedBloc = getIt<NewsfeedBloc>()..add(FetchTrendingFeedEvent());
    final network = getIt<NetworkChecker>();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      //_checkInternetConnection(network);
    });
    super.initState();
  }

  Future<void> _getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString('userId')!;
    });
  }

  void _loadUser() async {
    final userModel =
        await _hiveLocalStorage.load(key: "user", boxName: "cache");
    if (userModel != null) {
      logg.i("Người dùng đã lưu: $userModel");
      final userEntity = UserProfileMapper.toEntity(userModel);
      setState(() {
        userInfo = userEntity;
      });
    }
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

  void _upVote(String postId) {
    context.read<InteractBloc>().add(
          InteractPostEvent(
            userId: userId,
            postId: postId,
            voteType: 1,
          ),
        );
    logg.i('VoteType: 1');
  }

  void _downVote(String postId) {
    context.read<InteractBloc>().add(
          InteractPostEvent(
            userId: userId,
            postId: postId,
            voteType: 2,
          ),
        );
    logg.i('VoteType: 2');
  }

  void _unVote(String postId) {
    context.read<InteractBloc>().add(
          InteractPostEvent(
            userId: userId,
            postId: postId,
            voteType: 3,
          ),
        );
    logg.i('VoteType: 3');
  }

  void _savePost(String postId) {
    context.read<PostBloc>().add(
          SavePostEvent(
            userId: userId,
            postId: postId,
          ),
        );
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
        //BlocProvider(create: (_) => _newsfeedBloc),
        //BlocProvider(create: (_) => _exploreFeedBloc),
        BlocProvider(create: (_) => _trendingFeedBloc),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: AppBar(
          backgroundColor: AppColors.bgWhite,
          title: Row(
            children: [
              Image.asset(AppImages.logo, width: 30, height: 30),
              const Text(
                'Fitora',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bgPink,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                final result = await context.pushNamed(
                  AppRoute.post.name,
                  extra: userInfo,
                );
                if (result == true) {
                  context
                      .read<NewsfeedBloc>()
                      .add(FetchNewsfeedEvent()); // gọi lại API
                }
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                context.pushNamed(AppRoute.search.name);
              },
              icon: const Icon(Icons.search_outlined),
            ),
            // IconButton(
            //   onPressed: () {
            //     context.goNamed(AppRoute.notification.name);
            //   },
            //   // icon: const Icon(Icons.notifications),
            //   icon: Badge.count(
            //     count: 1,
            //     child: const Icon(Icons.notifications),
            //   ),
            // ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is SavePostSuccessState) {
              return AppDisplayMessage.success(context, 'Đã lưu bài viết');
            }
          },
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
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
                          selectedColor: AppColors.bgPink,
                          backgroundColor: Colors.white,
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
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
                    //context.read<NewsfeedBloc>().add(FetchNewsfeedEvent());
                    context.read<NewsfeedBloc>().add(FetchExploreFeedEvent());
                  },
                  child: NewsfeedWidget(
                    selectedCategory: categories[selectedIndex],
                    selectedIndex: selectedIndex,
                    userInfo: userInfo,
                    upVote: _upVote,
                    downVote: _downVote,
                    unVote: _unVote,
                    savePost: _savePost,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
