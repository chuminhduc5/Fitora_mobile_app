import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/auth/data/models/responses/auth_model.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/user_model.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/user_profile_model.dart';
import '../../../../core/utils/logger.dart';
import '../models/requests/sign_in_request.dart';
import '../models/requests/sign_up_request.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> signIn(SignInRequest model);

  Future<AuthModel> signUp(SignUpRequest model);

  Future<void> signOut();

  // Future<void> refreshToken();

  Future<UserProfileModel> fetchProfile();
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

      if (response.data["isSuccess"] == false) {
        throw AuthException();
      }

      final auth = AuthModel.fromJson(response.data);
      return auth;
    } on DioException catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> signUp(SignUpRequest model) async {
    try {
      final response = await _dioClient.post(
        ApiUrl.signUp,
        data: model.toJson(),
      );

      final user = response.data["data"]["user"];
      final token = response.data["data"]["token"];
      logg.i("User: $user");
      logg.i("Token: $token");

      if (user == null && token == null) {
        throw DuplicateEmailException();
      }

      final auth = AuthModel.fromJson(response.data);
      return auth;
    } on DioException catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dioClient.post(ApiUrl.signOut);
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<UserProfileModel> fetchProfile() async {
    try {
      final response = await _dioClient.get(ApiUrl.profile);
      final data = response.data["data"];
      return UserProfileModel.fromJson(data);
    } on DioException catch (e) {
      logger.e("DioException: ${e.message}");
      throw ServerException();
    }
  }
}
