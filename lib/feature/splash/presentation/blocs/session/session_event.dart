part of 'session_bloc.dart';

@immutable
abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object?> get props => [];
}

class CheckSignInStatusEvent extends SessionEvent {}
