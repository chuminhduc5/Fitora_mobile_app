import 'package:fitora_mobile_app/feature/auth/data/models/responses/auth_model.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/user_profile_model.dart';
import 'package:hive/hive.dart';

void configureAdapter() async {
  Hive.registerAdapter(AuthModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AuthTokenModelAdapter());
  Hive.registerAdapter(UserProfileModelAdapter());
  Hive.registerAdapter(RelationshipModelAdapter());
  Hive.registerAdapter(UserInfoModelAdapter());
}