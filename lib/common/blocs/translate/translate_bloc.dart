import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends HydratedBloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(const TranslateState("id", "ID", "EN")) {
    on<TranslateEvent>(_translateEnglish);
  }

  Future _translateEnglish(TranslateEvent event, Emitter emit) async {
    emit(TranslateState("en", "EN", state.countryCode));
  }

  @override
  TranslateState? fromJson(Map<String, dynamic> json) {
    return TranslateState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TranslateState state) {
    return state.toMap();
  }
}
