import 'package:get/get.dart';
import 'package:learn_getx/features/auth/controllers/auth_controller.dart';
import 'package:learn_getx/features/auth/helpers/auth_helpers.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthHelpers());
    Get.lazyPut(() => AuthController());
  }
}
