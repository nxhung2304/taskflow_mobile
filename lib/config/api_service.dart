import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:learn_getx/config/app_logging.dart';
import 'package:learn_getx/features/auth/constants/auth_constants.dart';
import 'package:learn_getx/features/auth/models/auth_tokens.dart';
import 'package:learn_getx/features/auth/services/auth_token_storage.dart';

class ApiService extends getx.GetxService {
  late Dio _dio;
  final log = AppLogging();

  String baseUrl;
  int connectTimeout;
  int receiveTimeout;

  ApiService({
    required this.baseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: connectTimeout),
        receiveTimeout: Duration(seconds: receiveTimeout),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ),
    );
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) {
    log.d('Request ${_dio.options.baseUrl}$path data: $data');

    return _request(() => _dio.post(path, data: data));
  }

  Future<Response> get(String path) {
    log.d('Request ${_dio.options.baseUrl}$path');

    return _request(() => _dio.post(path));
  }

  Future<Response> patch(String path, {Map<String, dynamic>? data}) {
    log.d('Request ${_dio.options.baseUrl}$path data: $data');

    return _request(() => _dio.patch(path, data: data));
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) {
    log.d('Request ${_dio.options.baseUrl}$path data: $data');

    return _request(() => _dio.delete(path, data: data));
  }

  Future<Response<T>> _request<T>(
    Future<Response<T>> Function() request,
  ) async {
    try {
      final response = await request();

      log.d('Response: ${response.statusCode} - ${response.data}');

      return response;
    } on DioException catch (e) {
      log.d('DioException: ${e.type} - ${e.message}');
      log.d('Response: ${e.response?.statusCode} - ${e.response?.data}');

      rethrow;
    } catch (e) {
      log.d('Unexpected error: $e');

      rethrow;
    }
  }

  setAuthHeaders(AuthTokens authTokens) {
    final headers = <String, String>{};
    headers.addAll({
      AuthConstants.accessToken: authTokens.accessToken,
      AuthConstants.client: authTokens.client,
      AuthConstants.uid: authTokens.uid,
      AuthConstants.expiry: authTokens.expiry,
    });
    _dio.options.headers.addAll(headers);

    log.d('Set auth headers: $headers');
  }

  clearAuthHeaders() {
    _dio.options.headers.remove(AuthConstants.accessToken);
    _dio.options.headers.remove(AuthConstants.client);
    _dio.options.headers.remove(AuthConstants.uid);
    _dio.options.headers.remove(AuthConstants.expiry);

    log.d('Cleared auth headers');
  }
}
