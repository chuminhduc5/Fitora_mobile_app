import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/user_post/user_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPostListWidget extends StatefulWidget {
  final String userId;

  const UserPostListWidget({super.key, required this.userId});

  @override
  State<UserPostListWidget> createState() => _UserPostListWidgetState();
}

class _UserPostListWidgetState extends State<UserPostListWidget> {
  late UserPostBloc _userPostBloc;

  @override
  void initState() {
    _userPostBloc = getIt<UserPostBloc>()
      ..add(FetchUserPostEvent(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userPostBloc,
      child: BlocBuilder<UserPostBloc, UserPostState>(builder: (context, state) {
        if (state is FetchUserPostLoadingState) {

        } else if (state is FetchUserPostFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchUserPostSuccessState) {
          final userPosts = state.data;
          // return CustomScrollView(
          //   slivers: [
          //     SliverList(
          //       delegate: SliverChildBuilderDelegate(
          //             (context, index) {
          //           final userPost = userPosts[index];
          //           return NewsfeedPostWidget(
          //             post: userPost,
          //           );
          //         },
          //         childCount: userPosts.length,
          //       ),
          //     ),
          //   ],
          // );
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: userPosts.length,
            itemBuilder: (context, index) {
              final userPost = userPosts[index];
              return NewsfeedPostWidget(post: userPost);
            },
          );
        }
        return const SizedBox();
      }),
    );
  }
}
