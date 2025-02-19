import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String userName;
  final String fullName;

  const UserEntity({
    required this.id,
    required this.userName,
    required this.fullName,
  });

  @override
  List<Object?> get props => [id, userName, fullName];
}
