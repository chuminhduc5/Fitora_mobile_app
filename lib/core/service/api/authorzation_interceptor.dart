import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationInterceptor extends Interceptor {
  // final Dio dio;
  //
  // AuthorizationInterceptor(this.dio);

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final token = sharedPreferences.getString('token');
  //   options.headers['Authorization'] = "Bearer $token";
  //   handler.next(options);
  // }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');

    if (token != null) {
      options.headers['Authorization'] = "Bearer $token";
    }
    handler.next(options);
  }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   if (err.response?.statusCode == 401) {
  //     // Nếu lỗi 401, thử refresh token
  //     final newToken = await _refreshToken();
  //
  //     if (newToken != null) {
  //       // Cập nhật token mới vào headers
  //       err.requestOptions.headers['Authorization'] = "Bearer $newToken";
  //
  //       // Thực hiện lại request với token mới
  //       final newResponse = await dio.fetch(err.requestOptions);
  //       return handler.resolve(newResponse);
  //     }
  //   }
  //   super.onError(err, handler);
  // }
  //
  // Future<String?> _refreshToken() async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final refreshToken = sharedPreferences.getString('refresh_token');
  //
  //   if (refreshToken == null) return null;
  //
  //   try {
  //     final response = await dio.post('/auth/refresh', data: {'refresh_token': refreshToken});
  //
  //     if (response.statusCode == 200) {
  //       final newToken = response.data['access_token'];
  //       await sharedPreferences.setString('token', newToken);
  //       return newToken;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  //   return null;
  // }
}
