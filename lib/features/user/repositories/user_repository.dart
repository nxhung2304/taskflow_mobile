import 'package:get/get.dart';
import 'package:learn_getx/config/app_endpoint.dart';
import 'package:learn_getx/config/app_logging.dart';
import 'package:learn_getx/config/models/api_response.dart';
import 'package:learn_getx/config/api_service.dart';

class UserRepository {
  final apiService = Get.find<ApiService>();
  final logging = Get.find<AppLogging>();

  Future<ApiResponse> me() async {
    logging.d('Starting get information for me');

    try {
      final res = await apiService.get(AppEndpoint.me);

      if (res.data == null) {
        throw Exception('No response data received from server');
      }

      return ApiResponse.fromJson(res.data);
    } catch (e) {
      logging.e('Error during me - $e');
      rethrow;
    }
  }
}
