import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/feature/home/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/get_newsfeed_use_case.dart';

class HomeDependency {
  HomeDependency._();

  static void init() {
    // Bloc
    getIt.registerFactory(() => NewsfeedBloc(getIt<GetNewsfeedUseCase>()));

    // UseCase

    // Repository

    // Datasource
  }
}
