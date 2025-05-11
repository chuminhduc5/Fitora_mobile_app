import 'package:fitora_mobile_app/app/app_view.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/auth_screen.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:fitora_mobile_app/feature/chat/presentation/screens/chat_screen.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/screens/notification_screen.dart';
import 'package:fitora_mobile_app/feature/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/home_screen.dart';
import 'package:fitora_mobile_app/feature/post/presentation/screens/post_articles_screen.dart';
import 'package:fitora_mobile_app/feature/splash/presentation/screens/splash_screen.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/create_group_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/friend_invitation_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/friend_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/invite_friend_group_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/personal_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/profile_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.onboarding.path,
        name: AppRoute.onboarding.name,
        //builder: (_, __) => const OnboardingScreen(),
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const OnboardingScreen(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
      ),
      // GoRoute(
      //   path: AppRoute.customizeCategory.path,
      //   name: AppRoute.customizeCategory.name,
      //   builder: (_, __) => const CustomizeCategoriesScreen(),
      // ),
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        //builder: (_, __) => const AuthScreen(),
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AuthScreen(),
            transitionDuration: const Duration(milliseconds: 1500),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
        routes: [
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
        ]
      ),
      GoRoute(
        path: AppRoute.appView.path,
        name: AppRoute.appView.name,
        //builder: (_, __) => const AppView(),
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AppView(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
          );
        },
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
        routes: [
          GoRoute(
            path: AppRoute.updateProfile.path,
            name: AppRoute.updateProfile.name,
            pageBuilder: (context, state) {
              final profile = state.extra as UserProfileEntity;
              return CustomTransitionPage(
                opaque: false,
                child: UpdateProfileScreen(profile: profile),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  );
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(curvedAnimation),
                    child: child,
                  );
                },
              );
            }
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.personal.path,
        name: AppRoute.personal.name,
        builder: (_, state) {
          final userId = state.extra as String;
          return PersonalScreen(userId: userId);
        },
      ),
      GoRoute(
        path: AppRoute.chat.path,
        name: AppRoute.chat.name,
        builder: (_, __) => const ChatScreen(),
      ),
      GoRoute(
        path: AppRoute.notification.path,
        name: AppRoute.notification.name,
        builder: (_, __) => const NotificationScreen(),
      ),
      GoRoute(
        path: AppRoute.group.path,
        name: AppRoute.group.name,
        builder: (_, state) {
          final groupId = state.extra as String;
          return GroupScreen(groupId: groupId);
        },
      ),
      GoRoute(
        path: AppRoute.createGroup.path,
        name: AppRoute.createGroup.name,
        builder: (_, __) => const CreateGroupScreen(),
      ),
      GoRoute(
        path: AppRoute.inviteFriendGroup.path,
        name: AppRoute.inviteFriendGroup.name,
        builder: (_, state) {
          final groupId = state.extra as String;
          return InviteFriendGroupScreen(groupId: groupId);
        },
      ),
      GoRoute(
        path: AppRoute.friends.path,
        name: AppRoute.friends.name,
        builder: (_, __) => const FriendScreen(),
      ),
      GoRoute(
        path: AppRoute.friendInvitation.path,
        name: AppRoute.friendInvitation.name,
        builder: (_, __) => const FriendInvitationScreen(),
      ),
    ],
  );
}
