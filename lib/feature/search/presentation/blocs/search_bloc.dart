import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/users/search_users_use_case.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUsersUseCase _searchUsersUseCase;

  SearchBloc(this._searchUsersUseCase) : super(SearchInitialState()) {
    on<SearchUserEvent>(_searchUser);
  }

  Future _searchUser(SearchUserEvent event, Emitter emit) async {
    emit(SearchUserLoadingState());

    final result = await _searchUsersUseCase.call(event.keySearch);

    result.fold(
      (failure) => emit(SearchUserFailureState(mapFailureToMessage(failure))),
      (success) => emit(SearchUserSuccessState(data: success)),
    );
  }
}
