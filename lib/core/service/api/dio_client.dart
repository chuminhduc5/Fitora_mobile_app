import 'package:dio/dio.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'api_exception.dart';
import 'logger_interceptor.dart';
import 'package:dio/io.dart';
import 'dart:io';

class DioClient {
  late final Dio _dio;

  // DioClient({required String baseUrl})
  //     : _dio = Dio(
  //         BaseOptions(
  //           baseUrl: baseUrl,
  //           headers: {"Content-Type": "application/json; charset=utf-8"},
  //           responseType: ResponseType.json,
  //           sendTimeout: const Duration(seconds: 10),
  //           receiveTimeout: const Duration(seconds: 10),
  //         ),
  //       )..interceptors.addAll(
  //           [AuthorizationInterceptor(), LoggerInterceptor()],
  //         );


  DioClient({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {"Content-Type": "application/json; charset=utf-8"},
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    )..interceptors.addAll(
      [AuthorizationInterceptor(), LoggerInterceptor()],
    );

    // 👇 Bypass chứng chỉ SSL tự ký (self-signed cert) khi gọi https://10.0.2.2
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        // In thêm log nếu cần kiểm tra chứng chỉ
        logg.w("Bypassing SSL certificate for host: $host");
        return true;
      };
      return client;
    };
  }

  // TODO: GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      //_handleDioError(e);
      rethrow;
    }
  }

  // TODO: POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      //_handleDioError(e);
      rethrow;
    }
  }

  // TODO: PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      //_handleDioError(e);
      logger.e("DioException: $e");
      rethrow;
    }
  }

  // TODO: DELETE METHOD
  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      //_handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception("Kết nối quá thời gian, vui lòng thử lại!");
      case DioExceptionType.sendTimeout:
        throw Exception("Gửi yêu cầu quá thời gian!");
      case DioExceptionType.receiveTimeout:
        throw Exception("Nhận dữ liệu quá thời gian!");
      case DioExceptionType.badResponse:
        logger.e("DioExceptionType: ${error.response?.statusCode}, ${error.response?.data}");
        _handleHttpError(error.response?.statusCode, error.response?.data);
        break;
      case DioExceptionType.cancel:
        throw Exception("Yêu cầu đã bị hủy!");
      case DioExceptionType.unknown:
        throw Exception("Lỗi không xác định, vui lòng thử lại!");
      default:
        logg.i("DioError type: ${error.type}");
        logg.i("DioError message: ${error.message}");
        logg.i("DioError: ${error.toString()}");
        throw Exception("Đã xảy ra lỗi, vui lòng thử lại!");
    }
  }

  void _handleHttpError(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        logger.e("HandleHttpError: $statusCode $data");
        throw BadRequestException("Lỗi yêu cầu không hợp lệ!");
      case 401:
        throw UnauthorizedException("Bạn cần đăng nhập lại!");
      case 403:
        throw ForbiddenException("Bạn không có quyền thực hiện hành động này!");
      case 404:
        throw NotFoundException("Không tìm thấy tài nguyên!");
      case 422:
        throw UnprocessableContentException("Dữ liệu không thể xử lý!");
      case 500:
        throw InternalServerException("Lỗi server, vui lòng thử lại sau!");
      default:
        throw ApiException("Lỗi không xác định! Mã lỗi: $statusCode");
    }
  }
}
