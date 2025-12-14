import 'package:get/get.dart';
import 'package:learn_getx/features/auth/controllers/auth_controller.dart';
import 'package:learn_getx/features/auth/services/auth_token_storage.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthTokenStorage(), permanent: true);
    Get.lazyPut(() => AuthController());
  }
}
