import 'package:get/get.dart';
import 'package:learn_getx/features/auth/controllers/auth_controller.dart';
import 'package:learn_getx/features/auth/repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => AuthController());
  }
}
