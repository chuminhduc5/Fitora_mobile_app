import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;

  const PostEntity({required this.id});

  @override
  List<Object?> get props => [id];
}