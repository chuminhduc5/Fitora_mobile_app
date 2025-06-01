import 'dart:io';
import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/group/joined_group_list_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/group/managed_group_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selectedIndex = 0;
  late GroupBloc _groupManagedBloc;
  late GroupBloc _groupJoinedBloc;

  String selectedCategory = 'Nhóm của bạn';
  final List<String> categories = [
    'Dành cho bạn',
    'Nhóm của bạn',
    'Bài viết',
    'Khám phá',
  ];

  @override
  void initState() {
    super.initState();
    _groupManagedBloc = getIt<GroupBloc>()..add(FetchManagedGroupEvent());
    _groupJoinedBloc = getIt<GroupBloc>()..add(FetchJoinedGroupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bgPink,
          title: const Text(
            "Cộng đồng",
            style: TextStyle(fontSize: 20, color: AppColors.white),
          ),
          actions: <Widget>[
            IconButton(onPressed: () {
              context.pushNamed(AppRoute.createGroup.name);
            }, icon: const Icon(Icons.add)),
            //IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
          ],
          iconTheme: const IconThemeData(color: AppColors.white),
        ),
        backgroundColor: AppColors.bgWhite,
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => _groupManagedBloc),
              BlocProvider(create: (context) => _groupJoinedBloc),
            ],
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  const Duration(seconds: 1),
                ).then(
                  (value) => context.read<GroupBloc>().add(
                        FetchManagedGroupEvent(),
                      ),
                );
              },
              child: Column(
                children: [
                  const TabBar(
                    indicatorWeight: 1,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppColors.bgPink,
                    //dividerColor: AppColors.white,
                    //dividerHeight: 0,
                    labelColor: AppColors.bgPink,
                    tabs: [
                      Tab(
                        text: "Nhóm bạn quản lý",
                      ),
                      Tab(
                        text: "Nhóm của bạn",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        BlocProvider<GroupBloc>.value(
                          value: _groupManagedBloc,
                          child: const ManagedGroupListWidget(),
                        ),
                        BlocProvider<GroupBloc>.value(
                          value: _groupJoinedBloc,
                          child: const JoinedGroupListWidget(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
