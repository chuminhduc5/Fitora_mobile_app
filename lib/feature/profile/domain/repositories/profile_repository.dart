import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either> getProfile();
}