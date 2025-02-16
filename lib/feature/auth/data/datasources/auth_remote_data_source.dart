import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/dio_client.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/params/sign_in_req_params.dart';

abstract class AuthRemoteDataSource {
  Future<Either> signIn(SignInReqParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either> signIn(SignInReqParams params) async {
    try {
      var response = await sl<DioClient>().post('', data: params.toMap());
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
