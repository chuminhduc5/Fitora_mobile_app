import 'package:fitora_mobile_app/app/service_locator.dart';
import 'package:fitora_mobile_app/core/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

Future<void> runnerApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  setupServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}