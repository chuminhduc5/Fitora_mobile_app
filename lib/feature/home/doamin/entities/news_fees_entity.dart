import 'package:equatable/equatable.dart';

class NewsFeedEntity extends Equatable {
  final String id;

  const NewsFeedEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
