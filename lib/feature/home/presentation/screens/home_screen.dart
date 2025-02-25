import 'dart:math';

import 'package:fitora_mobile_app/common/widgets/article/article_card.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/left_drawer/left_drawer.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _articleList = [
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Bài viêt mới",
      "content": "",
      "image": [],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image": [AppImages.avatar],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image": [AppImages.avatar, AppImages.avatar],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image": [AppImages.avatar, AppImages.avatar, AppImages.avatar],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar": AppImages.avatar,
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image": [AppImages.avatar, AppImages.avatar, AppImages.avatar, AppImages.avatar],
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
  ];

  // static const _pageSize = 10;
  // final PagingController<String?, PostEntity> _pagingController = PagingController(firstPageKey: null);
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _pagingController.addPageRequestListener((lastPostId) {
  //     _fetchPage(lastPostId);
  //   });
  // }
  //
  // Future<void> _fetchPage(String? lastPostId) async {
  //   try {
  //     final newPosts = await fetchPostsFromApi(lastPostId, _pageSize);
  //     final isLastPage = newPosts.length < _pageSize;
  //
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newPosts);
  //     } else {
  //       final nextPageKey = newPosts.last.id; // Cursor (ID bài viết cuối cùng)
  //       _pagingController.appendPage(newPosts, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: leftDrawer(),
      endDrawer: rightDrawer(context),
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgPink,
        title: const Text(
          'Fitora',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final article = _articleList[index];
                //logger.i(article['image']);
                return ArticleCard(
                  avatar: article['avatar'],
                  author: article['author'],
                  title: article['title'],
                  content: article['content'],
                  images: List<String>.from(article['image']) ?? [],
                  description: article['description'],
                  time: article['time'],
                  favourite: article['favourite'],
                  comment: article['comment'],
                  share: article['share'],
                );
              },
              childCount: _articleList.length,
            ),
          ),
        ],
      ),
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
