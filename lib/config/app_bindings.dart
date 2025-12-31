import 'package:get/get.dart';
import 'package:learn_getx/config/app_controller.dart';
import 'package:learn_getx/config/app_endpoint.dart';
import 'package:learn_getx/config/app_logging.dart';
import 'package:learn_getx/core/api_service.dart';
import 'package:learn_getx/features/auth/services/auth_token_storage.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthTokenStorage(), permanent: true);
    Get.put(AppLogging(), permanent: true);
    Get.put(ApiService(baseUrl: AppEndpoint.baseUrl, connectTimeout: 30, receiveTimeout: 30), permanent: true);

    Get.put(AppController(), permanent: true);
  }
}
