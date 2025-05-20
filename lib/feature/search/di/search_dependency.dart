import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/feature/search/presentation/blocs/search_bloc.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/users/search_users_use_case.dart';

class SearchDependency {
  SearchDependency._();

  static void init() {
    getIt.registerFactory(() => SearchBloc(getIt<SearchUsersUseCase>()));
  }
}