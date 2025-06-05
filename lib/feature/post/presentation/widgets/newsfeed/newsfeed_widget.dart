import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/loader/skeleton_loading.dart';
import 'package:fitora_mobile_app/common/widgets/post/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsfeedWidget extends StatelessWidget {
  final String selectedCategory;
  final int? selectedIndex;
  final UserProfileEntity? userInfo;
  final void Function(String)? upVote;
  final void Function(String)? unVote;
  final void Function(String)? downVote;
  final void Function(String)? savePost;

  const NewsfeedWidget({
    super.key,
    required this.selectedCategory,
    this.selectedIndex,
    this.userInfo,
    this.upVote,
    this.unVote,
    this.downVote,
    this.savePost,
  });

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<NewsfeedBloc, NewsfeedState>(
    //   builder: (context, state) {
    //     if (state is FetchNewsfeedLoadingState) {
    //       return ListView.builder(
    //         itemCount: 5,
    //         itemBuilder: (context, index) => const SkeletonLoading(),
    //       );
    //     } else if (state is FetchNewsfeedFailureState) {
    //       return AppErrorWidget(state.message);
    //     } else if (state is FetchNewsfeedSuccessState) {
    //       final newsfeeds = state.data;
    //       final filteredNewsfeeds = selectedCategory == 'Tất cả'
    //           ? newsfeeds
    //           : newsfeeds
    //               .where((post) => post.categoryName == selectedCategory)
    //               .toList();
    //       return CustomScrollView(
    //         slivers: [
    //           SliverList(
    //             delegate: SliverChildBuilderDelegate(
    //               (context, index) {
    //                 final newsfeed = filteredNewsfeeds[index];
    //                 return NewsfeedPostWidget(
    //                   post: newsfeed,
    //                   userId: userId,
    //                 );
    //               },
    //               childCount: filteredNewsfeeds.length,
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //     return const SizedBox();
    //   },
    // );

    return BlocBuilder<NewsfeedBloc, NewsfeedState>(
      builder: (context, state) {
        if (state is FetchExploreFeedLoadingState) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => const SkeletonLoading(),
          );
        } else if (state is FetchExploreFeedFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchExploreFeedSuccessState) {
          final newsfeeds = state.data;
          final filteredNewsfeeds = selectedCategory == 'Tất cả'
              ? newsfeeds
              : newsfeeds
              .where((post) => post.categoryName == selectedCategory)
              .toList();
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final newsfeed = filteredNewsfeeds[index];
                    return NewsfeedPostWidget(
                      post: newsfeed,
                      userInfo: userInfo,
                      upVote: upVote,
                      unVote: upVote,
                      downVote: downVote,
                      savePost: savePost,
                    );
                  },
                  childCount: filteredNewsfeeds.length,
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
