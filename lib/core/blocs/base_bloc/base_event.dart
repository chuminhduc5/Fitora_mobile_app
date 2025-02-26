part of 'base_bloc.dart';

@immutable
abstract class BaseEvent extends Equatable {}

class OnInitial extends BaseEvent {
  @override
  List<Object?> get props => [];
}

class OnChange<T> extends BaseEvent {
  final T value;

  OnChange(this.value);

  @override
  List<Object?> get props => [value];
}
