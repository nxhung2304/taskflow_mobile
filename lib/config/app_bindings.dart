import 'package:get/get.dart';
import 'package:learn_getx/config/app_controller.dart';
import 'package:learn_getx/config/app_endpoint.dart';
import 'package:learn_getx/config/app_logging.dart';
import 'package:learn_getx/core/api_service.dart';
import 'package:learn_getx/core/local_storage.dart';
import 'package:learn_getx/core/models/auth_token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<ILocalStorage>(() async {
      final prefs = await SharedPreferences.getInstance();
      return LocalStorage(prefs);
    }, permanent: true);

    Get.put<AuthTokenStorage>(AuthTokenStorage(Get.find()), permanent: true);

    Get.put(AppLogging(), permanent: true);
    Get.put(
      ApiService(
        baseUrl: AppEndpoint.baseUrl,
        connectTimeout: 30,
        receiveTimeout: 30,
      ),
      permanent: true,
    );

    Get.put(AppController(), permanent: true);
  }
}
