import 'package:fitora_mobile_app/common/widgets/post/newsfeed_post_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatefulWidget {
  const PostListWidget({super.key});

  @override
  State<PostListWidget> createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  final List<Map<String, dynamic>> _articleList = [
    {
      "avatar": AppImages.avatar,
      "author": "Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "new",
      "image": AppImages.bgImage,
      "description": "",
      "time": "2025-03-05T22:47:43.128427+07:00",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "content": "test",
      "image": AppImages.bgImageSecond,
      "description": "",
      "time": "2025-03-05T22:47:43.128427+07:00",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "content": "test",
      "image": AppImages.bgImageThird,
      "description": "",
      "time": "2025-03-05T22:47:43.128427+07:00",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Minh Đức",
      "content": "Test đăng bài",
      "image": "",
      "description": "",
      "time": "2025-03-05T22:47:43.128427+07:00",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final article = _articleList[index];
              // return NewsfeedPostWidget(
              //   avatar: article['avatar'],
              //   author: article['author'],
              //   content: article['content'],
              //   images: article["image"],
              //   favourite: article['favourite'],
              //   comment: article['comment'],
              //   share: article['share'],
              //   //time: article['time'],
              // );
                  return SizedBox();
            },
            childCount: _articleList.length,
          ),
        ),
      ],
    );
  }
}
