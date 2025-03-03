import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/auth/data/models/responses/auth_model.dart';
import '../../../../core/utils/logger.dart';
import '../models/requests/sign_in_request.dart';
import '../models/requests/sign_up_request.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> signIn(SignInRequest model);
  Future<void> signUp(SignUpRequest model);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  const AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<AuthModel> signIn(SignInRequest model) async {
    try {
      var response = await _dioClient.post(
        ApiUrl.signIn,
        data: model.toJson(),
      );
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> signUp(SignUpRequest model) async {
    try {
      await _dioClient.post(
        ApiUrl.signUp,
        data: model.toJson(),
      );
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
