import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../error/failure.dart';

typedef EitherNetwork<T> = Future<Either<Failure, T>> Function();

class NetworkChecker {
  final InternetConnectionChecker _connectionChecker;

  NetworkChecker(this._connectionChecker);

  bool _isConnected = true;

  Future<Either<Failure, T>> check<T>({
    required EitherNetwork<T> connected,
    required EitherNetwork<T> notConnected,
  }) async {
    final isConnected = await checkIsConnected;
    if (isConnected) {
      return connected.call();
    } else {
      return notConnected.call();
    }
  }

  Future<bool> get checkIsConnected async =>
      await _connectionChecker.hasConnection;

  set setIsConnected(bool val) => _isConnected = val;

  bool get getIsConnected => _isConnected;
}
