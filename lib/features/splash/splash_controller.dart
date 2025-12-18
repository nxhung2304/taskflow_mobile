import 'package:get/get.dart';
import 'package:learn_getx/config/app_controller.dart';
import 'package:learn_getx/config/app_helpers.dart';
import 'package:learn_getx/config/app_routes.dart';
import 'package:learn_getx/features/splash/splash_constants.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await AppHelpers.delay(SplashConstants.delay);

    try {
      final appController = Get.find<AppController>();

      while (!appController.isInitialized.value) {
        await Future.delayed(Duration(milliseconds: 100));
      }

      _navigateBasedOnAuth(appController.isAuthenticated.value);
    } catch (e) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void _navigateBasedOnAuth(bool isAuthenticated) {
    if (isAuthenticated) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
