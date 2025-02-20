import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetryAttempts;

  RetryInterceptor({required this.dio, this.maxRetryAttempts = 3});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError && maxRetryAttempts > 0) {
      for (int i = 0; i < maxRetryAttempts; i++) {
        try {
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (_) {}
      }
    }
    super.onError(err, handler);
  }
}
