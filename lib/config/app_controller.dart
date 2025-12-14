import 'package:get/get.dart';
import 'package:learn_getx/features/auth/helpers/auth_helpers.dart';

class AppController extends GetxController {
  static AppController shared = Get.find<AppController>();

  RxBool isAuthenticated = false.obs;
  RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();

    _initializeAuthState();
  }

  void _initializeAuthState() {
    try {
      final authHelpers = AuthHelpers();
      isAuthenticated.value = authHelpers.validAuthTokens();
    } catch (e) {
      isAuthenticated.value = false;
    } finally {
      isInitialized.value = true;
    }
  }
}
