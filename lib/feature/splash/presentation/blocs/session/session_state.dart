part of 'session_bloc.dart';

@immutable
abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

class SessionInitialState extends SessionState {}

class CheckSignInStatusLoadingState extends SessionState {}

class CheckSignInStatusSuccessState extends SessionState {
  final AuthEntity data;

  const CheckSignInStatusSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class CheckSignInStatusFailureState extends SessionState {
  final String message;

  const CheckSignInStatusFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
