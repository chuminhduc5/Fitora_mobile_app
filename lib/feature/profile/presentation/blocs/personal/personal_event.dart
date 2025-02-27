part of 'personal_bloc.dart';

@immutable
abstract class PersonalEvent extends Equatable {
  const PersonalEvent();

  @override
  List<Object?> get props => [];
}

class FetchPersonalEvent extends PersonalEvent {}
