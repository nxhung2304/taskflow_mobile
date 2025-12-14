import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:learn_getx/config/app_endpoint.dart';
import 'package:learn_getx/config/app_logging.dart';
class ApiService extends getx.GetxService {
  late Dio _dio;
  final log = AppLogging();

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(
      BaseOptions(
        baseUrl: AppEndpoint.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
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

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    var fullUrl = _dio.options.baseUrl + path;
    AppLogging().d('POST request to $fullUrl with data: $data');

    try {
      final response = await _dio.post(path, data: data);
      AppLogging().d(
        'ApiService: Response received: ${response.statusCode} - ${response.data}',
      );
      return response;
    } on DioException catch (e) {
      AppLogging().d('DioException occurred: ${e.type} - ${e.message}');
      AppLogging().d(
        'Response: ${e.response?.statusCode} - ${e.response?.data}',
      );
      rethrow;
    } catch (e) {
      AppLogging().d('Unexpected error: ${e.hashCode}');
      rethrow;
    }
  }

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
