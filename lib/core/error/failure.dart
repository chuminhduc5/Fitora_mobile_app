import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure(this.message);

  @override
  List<Object?> get props => [];
}

class DataInputFailure extends Failure {
  const DataInputFailure({String? message}) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String? message}) : super(message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String? message}) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({String? message}) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({String? message}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({String? message}) : super(message);
}

class EmptyFailure extends Failure {
  const EmptyFailure({String? message}) : super(message);
}

class CredentialFailure extends Failure {
  const CredentialFailure({String? message}) : super(message);
}

class DuplicateEmailFailure extends Failure {
  const DuplicateEmailFailure({String? message}) : super(message);
}

class PasswordNotMatchFailure extends Failure {
  const PasswordNotMatchFailure({String? message}) : super(message);
}

class InvalidEmailFailure extends Failure {
  const InvalidEmailFailure({String? message}) : super(message);
}

class InvalidPasswordFailure extends Failure {
  const InvalidPasswordFailure({String? message}) : super(message);
}