import 'dart:io';

import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/post/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/home/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsfeedWidget extends StatelessWidget {
  const NewsfeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsfeedBloc, NewsfeedState>(builder: (context, state) {
      if (state is FetchNewsfeedLoadingState) {
        return const AppLoadingWidget();
      } else if (state is FetchNewsfeedFailureState) {
        return AppErrorWidget(state.message);
      } else if (state is FetchNewsfeedSuccessState) {
        final newsfeeds = state.data;
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final newsfeed = newsfeeds[index];
                  //logger.i(article['image']);
                  final avatar = newsfeed.mediaUrl;
                  logg.i("Avatar: $avatar");
                  return NewsfeedPostWidget(
                    avatar: avatar,
                    images: [File(newsfeed.mediaUrl)],
                    content: newsfeed.content,
                    time: newsfeed.createAt,
                    favourite: newsfeed.privacy,
                    comment: newsfeed.commentsCount,
                    share: newsfeed.votesCount,
                  );
                },
                childCount: newsfeeds.length,
              ),
            ),
          ],
        );
      }
      return const SizedBox();
    });
  }
}
