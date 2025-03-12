import 'package:fitora_mobile_app/app/app_view.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:fitora_mobile_app/feature/chat/presentation/screens/chat_screen.dart';
import 'package:fitora_mobile_app/feature/home/presentation/screens/home_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/post_articles_screen.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/screens/edit_profile_screen.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/screens/personal_screen.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/screens/profile_screen.dart';
import 'package:fitora_mobile_app/feature/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.signIn.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.signIn.path,
        name: AppRoute.signIn.name,
        builder: (_, __) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoute.signUp.path,
        name: AppRoute.signUp.name,
        builder: (_, __) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoute.appView.path,
        name: AppRoute.appView.name,
        builder: (_, __) => const AppView(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoute.post.path,
        name: AppRoute.post.name,
        builder: (_, __) => const PostArticlesScreen(),
      ),
      GoRoute(
        path: AppRoute.profile.path,
        name: AppRoute.profile.name,
        builder: (_, __) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoute.editProfile.path,
        name: AppRoute.editProfile.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          opaque: false,
          child: const EditProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );
            var reverseAnimation = CurvedAnimation(
              parent: secondaryAnimation,
              curve: Curves.easeInOut,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
            // return Stack(
            //   children: [
            //     SlideTransition(
            //       position: Tween<Offset>(
            //         begin: const Offset(1, 0),
            //         end: Offset.zero,
            //       ).animate(curvedAnimation),
            //       child: child,
            //     ),
            //     SlideTransition(
            //       position: Tween<Offset>(
            //         begin: Offset.zero,
            //         end: const Offset(1, 0),
            //       ).animate(reverseAnimation),
            //       child: child,
            //     ),
            //   ],
            // );
          },
        ),
      ),
      GoRoute(
        path: AppRoute.personal.path,
        name: AppRoute.personal.name,
        builder: (_, __) => const PersonalScreen(),
      ),
      GoRoute(
        path: AppRoute.chat.path,
        name: AppRoute.chat.name,
        builder: (_, __) => const ChatScreen(),
      ),
    ],
  );
}
