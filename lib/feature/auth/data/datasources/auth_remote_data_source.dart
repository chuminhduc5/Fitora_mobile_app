import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/constants/api_constant.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/auth/data/models/auth_model.dart';
import 'package:fitora_mobile_app/feature/auth/data/models/user_model.dart';

import '../../../../core/utils/logger.dart';
import '../models/auth_token_model.dart';
import '../models/request/sign_in_req_model.dart';
import '../models/request/sign_up_req_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> signIn(SignInReqModel model);

  Future<void> signUp(SignUpReqModel model);

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthModel> signIn(SignInReqModel model) async {
    try {
      var response = await getIt<DioClient>().post(
        ApiConstant.signIn,
        data: model.toMap(),
      );
      print("✅ API Response: ${response.statusCode} - ${response.data}");
      if (response.statusCode == 200) {
        print('Thành công');
        return AuthModel.fromJson(response.data);
      }  else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
      //return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> signUp(SignUpReqModel model) async {
    try {
      await getIt<DioClient>().post(
        ApiConstant.signUp,
        data: model.toMap(),
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
