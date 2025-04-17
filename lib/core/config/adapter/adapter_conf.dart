import 'package:fitora_mobile_app/core/config/adapter/adapter.dart';
import 'package:hive/hive.dart';

void configureAdapter() {
  Hive.registerAdapter(AuthAdapter());
}