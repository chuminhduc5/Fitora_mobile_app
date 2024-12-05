import 'package:fitora_mobile_app/common/widgets/appbar/app_bar.dart';
import 'package:fitora_mobile_app/feature/chat/presentation/screens/chat_screen.dart';
import 'package:fitora_mobile_app/feature/communities/presentation/screens/community_screen.dart';
import 'package:fitora_mobile_app/feature/home/presentation/screens/home_screen.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/screens/notification_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/post_articles_screen.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final List<Widget> _screen = [
    const HomeScreen(),
    const CommunityScreen(),
    const PostArticlesScreen(),
    const ChatScreen(),
    const NotificationScreen(),
  ];
  int _currentIndex = 0;
  SnackBarBehavior? _snackBarBehavior = SnackBarBehavior.floating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Fitora',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.orangeAccent),
          ),
          // leading: Builder(
          //   builder: (context) {
          //     return IconButton(
          //       onPressed: () {
          //         Scaffold.of(context).openDrawer();
          //       },
          //       icon: const Icon(Icons.notifications),
          //     );
          //   },
          // ),
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.orangeAccent,
                      child: Text('F'),
                    ),
                  ),
                );
              }
            )
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide.none,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 40,
              ),
              ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide.none,
                ),
                // collapsedShape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(0),
                //   side: BorderSide.none,
                // ),
                title: const Text('Cộng đồng của bạn', style: TextStyle(fontSize: 15),),
                minTileHeight: 20,
                initiallyExpanded: true,
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 15),
                    leading: const Icon(Icons.add, size: 20,),
                    title: const Text('Tạo mới', style: TextStyle(fontSize: 14),),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 15),
                    leading: const CircleAvatar(
                      radius: 12,
                      child: Text('H', style: TextStyle(fontSize: 13),),
                    ),
                    title: const Text('Tất cả', style: TextStyle(fontSize: 14),),
                    trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.star_border, size: 20,),),
                    onTap: () {},
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 15),
                    leading: const CircleAvatar(
                      radius: 12,
                      child: Text('H', style: TextStyle(fontSize: 13),),
                    ),
                    title: const Text('Tất cả', style: TextStyle(fontSize: 14),),
                    trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.star_border, size: 20,),),
                    onTap: () {},
                  ),
                ],
              ),
              ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide.none,
                ),
                title: const Text('Tất cả', style: TextStyle(fontSize: 15),),
                minTileHeight: 20,
                children: <Widget>[],
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide.none,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 40,
              ),
              ListTile(
                title: const Text('Mục 1'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Mục 2'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation, secondAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: _screen[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Cộng đồng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Thêm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Trò chuyện',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Thông báo',
            ),
          ],
        ),

    );
  }
}
