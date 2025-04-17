import 'dart:io';

import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/home/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsfeedWidget extends StatelessWidget {
  final String selectedCategory;
  const NewsfeedWidget({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsfeedBloc, NewsfeedState>(
      builder: (context, state) {
        if (state is FetchNewsfeedLoadingState) {
          return const AppLoadingWidget();
        } else if (state is FetchNewsfeedFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchNewsfeedSuccessState) {
          final newsfeeds = state.data;
          final filteredNewsfeeds = selectedCategory == 'Tất cả'
              ? newsfeeds
              : newsfeeds.where((post) => post.categoryName == selectedCategory).toList();
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final newsfeed = filteredNewsfeeds[index];
                    return NewsfeedPostWidget(
                      post: newsfeed,
                      onPressed: () {},
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
