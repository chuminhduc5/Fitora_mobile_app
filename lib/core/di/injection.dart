import 'package:fitora_mobile_app/core/service/dio_client.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void configureDependencies() {
  sl.registerSingleton<DioClient>(DioClient());
}