import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/config/adapter/adapter_conf.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/utils/simple_bloc_observer.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/user_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';

Future<void> runnerApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting('vi', null);
  //await dotenv.load(fileName: '.env');
  await dotenv.load(fileName: '.env.product');

  await Hive.initFlutter();

  late final HydratedStorage storage;

  if (!kIsWeb) {
    final tempDir = await getTemporaryDirectory();
    storage = await HydratedStorage.build(storageDirectory: tempDir);
  } else {
    storage = await HydratedStorage.build(storageDirectory: HydratedStorage.webStorageDirectory);
  }

  HydratedBloc.storage = storage;

  configureAdapter();
  configureDependencies();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
