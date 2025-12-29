import 'package:get/get.dart';
import 'package:learn_getx/config/app_controller.dart';
import 'package:learn_getx/config/app_routes.dart';
import 'package:learn_getx/features/splash/splash_constants.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final appController = Get.find<AppController>();

    try {
      await Future.delayed(Duration(seconds: SplashConstants.delaySeconds));
      while (!appController.isInitialized.value) {
        await Future.delayed(
          Duration(
            milliseconds: SplashConstants.delayForInitializationMilliseconds,
          ),
        );
      }
    } finally {
      final targetScreen = _getTargetScreen(appController);
      Get.offAllNamed(targetScreen);
    }
  }

  String _getTargetScreen(AppController appController) {
    return appController.isAuthenticated.value
        ? AppRoutes.home
        : AppRoutes.login;
  }
}
