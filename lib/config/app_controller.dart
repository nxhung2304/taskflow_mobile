import 'package:get/get.dart';
import 'package:learn_getx/features/auth/services/auth_token_storage.dart';

class AppController extends GetxController {
  final AuthTokenStorage authTokenStorage = Get.find<AuthTokenStorage>();

  RxBool isAuthenticated = false.obs;
  RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();

    _initializeAuthState();
  }

  void _initializeAuthState() {
    try {
      final tokens = authTokenStorage.load();
      isAuthenticated.value = tokens.isValid();
    } catch (e) {
      isAuthenticated.value = false;
    } finally {
      isInitialized.value = true;
    }
  }
}
