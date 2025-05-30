import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/loader/skeleton_loading.dart';
import 'package:fitora_mobile_app/common/widgets/post/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsfeedWidget extends StatelessWidget {
  final String selectedCategory;
  final void Function(String)? upVote;
  final void Function(String)? unVote;
  final void Function(String)? downVote;

  const NewsfeedWidget({
    super.key,
    required this.selectedCategory,
    this.upVote,
    this.unVote,
    this.downVote,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsfeedBloc, NewsfeedState>(
      builder: (context, state) {
        if (state is FetchNewsfeedLoadingState) {
          //return const AppLoadingWidget();
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => const SkeletonLoading(),
          );
        } else if (state is FetchNewsfeedFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchNewsfeedSuccessState) {
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
                      upVote: upVote,
                      unVote: upVote,
                      downVote: downVote,
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
