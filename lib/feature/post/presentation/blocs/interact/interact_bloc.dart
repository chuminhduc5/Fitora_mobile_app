import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'interact_event.dart';
part 'interact_state.dart';

class InteractBloc extends Bloc<InteractEvent, InteractState> {
  InteractBloc() : super(InteractInitial()) {
    on<InteractEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
