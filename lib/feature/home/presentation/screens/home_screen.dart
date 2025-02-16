import 'package:fitora_mobile_app/common/widgets/article/article_card.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/left_drawer/left_drawer.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _articleList = [
    {
      "avatar":
          "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg",
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image":
          "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg",
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar":
          "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg",
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image":
          "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg",
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
    {
      "avatar":
          "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg",
      "author": "Chử Minh Đức",
      "title": "Chử minh đức đã cập nhật ảnh đại diện mới",
      "content": "",
      "image":
          "https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg",
      "description": "",
      "time": "2 giờ trước",
      "favourite": 120,
      "comment": 50,
      "share": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: leftDrawer(),
      endDrawer: rightDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.bgOrange,
        title: const Text(
          'Fitora',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white),
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
          Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network("https://cdn-media.sforum.vn/storage/app/media/THANHAN/avartar-anime-89.jpg", height: 33, fit: BoxFit.cover,),
                    ),
                  ),
                );
              }
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final article = _articleList[index];
                return ArticleCard(
                  avatar: article['avatar'],
                  author: article['author'],
                  title: article['title'],
                  content: article['content'],
                  image: article['image'],
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
