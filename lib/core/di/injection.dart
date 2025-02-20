import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/auth/di/auth_dependency.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  AuthDependency.init();

  getIt.registerSingleton<DioClient>(DioClient());
}