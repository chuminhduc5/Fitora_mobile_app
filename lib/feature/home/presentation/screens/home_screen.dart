import 'dart:async';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/left_drawer/left_drawer.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer.dart';
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
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                context.read<NewsfeedBloc>().add(FetchNewsfeedEvent());
              },
              child: const NewsfeedWidget(),
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
}
