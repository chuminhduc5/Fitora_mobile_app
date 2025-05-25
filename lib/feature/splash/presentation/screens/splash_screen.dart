// import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
// import 'package:fitora_mobile_app/core/di/injection.dart';
// import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
// import 'package:fitora_mobile_app/feature/splash/presentation/blocs/session/session_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<SessionBloc>()..add(CheckSignInStatusEvent()),
//       child: BlocListener<SessionBloc, SessionState>(
//         listener: (context, state) {
//           if (state is CheckSignInStatusSuccessState) {
//             //context.goNamed(AppRoute.appView.name);
//             context.pushReplacementNamed(AppRoute.appView.name);
//           } else if (state is CheckSignInStatusFailureState) {
//             //context.pushReplacementNamed(AppRoute.auth.name);
//             context.pushReplacementNamed(AppRoute.onboarding.name);
//           }
//         },
//         child: const Scaffold(
//           backgroundColor: AppColors.bgPink,
//           body: SafeArea(
//             child: Center(
//               child: Text(
//                 "Fitora",
//                 style: TextStyle(
//                   color: AppColors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
