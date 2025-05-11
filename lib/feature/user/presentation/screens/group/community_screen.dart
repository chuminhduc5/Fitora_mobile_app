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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selectedIndex = 0;
  late GroupBloc _groupBloc;

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
    _groupBloc = getIt<GroupBloc>()..add(FetchManagedGroupEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GroupBloc>().add(FetchManagedGroupEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        title: const Text(
          "Tạo bài viết",
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
        ],
      ),
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => _groupBloc),
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
                // Category Selector
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
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color:
                                  isSelected ? Colors.black : Colors.grey[700],
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

                // 👇 Bọc phần còn lại trong Expanded
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: AppButtonWidget(
                            onPressed: () {
                              context.pushNamed(AppRoute.createGroup.name);
                              logg.i("Tạo nhóm mới");
                            },
                            title: "Tạo nhóm mới",
                            bgColor: AppColors.grey,
                            paddingTop: 10,
                            paddingBottom: 10,
                            fontSize: 15,
                            color: Colors.black,
                            prefixIcon: const Icon(Icons.add, color: AppColors.black,),
                          ),
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<GroupBloc, GroupState>(
                          builder: (context, state) {
                            if (state is FetchManagedGroupLoadingState) {
                              return const AppLoadingWidget();
                            } else if (state is FetchManagedGroupFailureState) {
                              return AppErrorWidget(state.message);
                            } else if (state is FetchManagedGroupSuccessState) {
                              final data = state.data;
                              return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final group = data[index];
                                  return ListTile(
                                    onTap: () {
                                      logg.i(AppRoute.group.name);
                                      logg.i(
                                          "Go to GroupScreen ID:${group.id}");
                                      context.pushNamed(
                                        AppRoute.group.name,
                                        extra: group.id,
                                      );
                                    },
                                    leading: AppAvatarWidget(imagePath: group.avatarUrl, size: 40),
                                    title: Text(group.name),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          '${group.memberCount.toString()} thành viên',
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.blue,
                                          size: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
