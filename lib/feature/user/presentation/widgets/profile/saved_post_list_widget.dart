import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/skeleton_loading.dart';
import 'package:fitora_mobile_app/common/widgets/post/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/saved_post/saved_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedPostListWidget extends StatelessWidget {
  const SavedPostListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedPostBloc, SavedPostState>(
      builder: (context, state) {
        if (state is FetchSavedPostLoadingState) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => const SkeletonLoading(),
          );
        } else if (state is FetchSavedPostFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchSavedPostSuccessState) {
          final savedPosts = state.data;
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final savedPost = savedPosts[index];
                    return NewsfeedPostWidget(
                      post: savedPost,
                    );
                  },
                  childCount: savedPosts.length,
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
