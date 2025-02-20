import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

Future<void> runnerApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Future.wait([
    //Hive.initFlutter(),
    getTemporaryDirectory().then((path) async {
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: path,
      );
    })
  ]);
  configureDependencies();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
