import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_check_sign_in_status_use_case.dart';
import 'package:fitora_mobile_app/feature/splash/presentation/blocs/session/session_bloc.dart';

class SplashDependency {
  SplashDependency._();

  static void init() {
    // Bloc
    getIt.registerFactory(() => SessionBloc(getIt<AuthCheckSignInStatusUseCase>()));

    // UseCase

    // Repository

    // Datasource
  }
}
