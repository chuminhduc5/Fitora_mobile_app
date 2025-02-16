part of 'translate_bloc.dart';

@immutable
sealed class TranslateEvent extends Equatable{
  const TranslateEvent();

  @override
  List<Object?> get props => [];
}

class TranslateEnglishEvent extends TranslateEvent {}
