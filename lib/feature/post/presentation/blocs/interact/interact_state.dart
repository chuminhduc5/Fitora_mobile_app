part of 'interact_bloc.dart';

@immutable
abstract class InteractState extends Equatable {
  const InteractState();

  @override
  List<Object?> get props => [];
}

class InteractPostInitialState extends InteractState {}

class InteractPostLoadingState extends InteractState {}

class InteractPostSuccessState extends InteractState {}

class InteractPostFailureState extends InteractState {
  final String message;

  const InteractPostFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
