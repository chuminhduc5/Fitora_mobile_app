import 'package:fitora_mobile_app/common/widgets/appbar/app_bar.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/left_drawer/left_drawer.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/feature/chat/presentation/screens/chat_screen.dart';
import 'package:fitora_mobile_app/feature/communities/presentation/screens/community_screen.dart';
import 'package:fitora_mobile_app/feature/home/presentation/screens/home_screen.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/screens/notification_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/post_articles_screen.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Fitora',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.orangeAccent),
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
          drawer: leftDrawer(),
          endDrawer: rightDrawer(),
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
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Cộng đồng',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Thêm',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppSvg.chatSvg, color: Colors.white,),
                label: 'Trò chuyện',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppSvg.notificationSvg, height: 25, width: 25, color: Colors.white,),
                label: 'Thông báo',
              ),
            ],
          ),
      
      ),
    );
  }
}
