import 'package:fitora_mobile_app/app/app_view.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:fitora_mobile_app/feature/chat/presentation/screens/chat_screen.dart';
import 'package:fitora_mobile_app/feature/home/presentation/screens/home_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/post_articles_screen.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/screens/personal_screen.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/screens/profile_screen.dart';
import 'package:fitora_mobile_app/feature/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AppView(),
      routes: [
        GoRoute(
          path: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: 'sign-in',
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: 'sign-up',
          builder: (context, state) => const SignUpScreen(),
        ),
        // GoRoute(
        //   path: 'app-view',
        //   builder: (context, state) => const AppView(),
        // ),
        GoRoute(
          path: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: 'post',
          builder: (context, state) => const PostArticlesScreen(),
        ),
        GoRoute(
          path: 'chat',
          pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true,
            child: ChatScreen(),
          ),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: 'personal',
          builder: (context, state) => const PersonalScreen(),
        ),
      ],
    )
  ],
);

// class AppRouter {
//   GoRouter get router => _router;
//
//   late final _router = GoRouter(
//     initialLocation: '/',
//     debugLogDiagnostics: true,
//     routes: [
//
//     ]
//   );
// }
