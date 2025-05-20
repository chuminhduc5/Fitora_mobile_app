import 'package:animations/animations.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/chat/presentation/screens/chat_screen.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/screens/notification_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/home_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/post_articles_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/community_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _currentIndex = 0;
  final List<Widget> _screen = [
    const HomeScreen(),
    const CommunityScreen(),
    const ChatScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
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
            backgroundColor: AppColors.bgWhite,
            selectedItemColor: AppColors.bgPink,
            unselectedItemColor: Colors.grey[400],
            selectedFontSize: 12,
            unselectedFontSize: 10,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Nhóm',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Trò chuyện',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Thông báo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Cá nhân'
              ),
            ],
          ),
      
      ),
    );
  }
}
