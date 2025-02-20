import 'dart:developer';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- bloc: ${bloc.runtimeType}');
  }

  // In ra các sự kiện Bloc
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  // In ra những thay đổi Bloc
  @override
  void onChange(BlocBase bloc, Change change) {
    logger.i('Current State: ${change.currentState}');
    logger.i('Next State: ${change.nextState}');
    super.onChange(bloc, change);
  }

  // In ra sự chuyển tiếp
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  // In ra các lỗi
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i('Error: $error');
    super.onError(bloc, error, stackTrace);
  }

  // Đóng
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- bloc: ${bloc.runtimeType}');
  }
}