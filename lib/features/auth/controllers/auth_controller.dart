import 'package:get/get.dart';
import 'package:learn_getx/config/app_controller.dart';
import 'package:learn_getx/config/app_logging.dart';
import 'package:learn_getx/config/app_routes.dart';
import 'package:learn_getx/features/auth/services/auth_token_storage.dart';
import 'package:learn_getx/features/auth/forms/login_form.dart';
import 'package:learn_getx/features/auth/models/user.dart';
import 'package:learn_getx/features/auth/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthTokenStorage authTokenStorage = Get.find<AuthTokenStorage>();
  final AuthRepository authRepository = Get.find<AuthRepository>();
  final AppController appController = Get.find<AppController>();

  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  Rxn<User> user = Rxn<User>();
  RxString email = ''.obs;
  RxString password = ''.obs;

  Future<void> login(LoginForm form) async {
    final formErr = form.validate();

    if (formErr != null) {
      error.value = formErr;
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final isLoggedIn = await authRepository.login(form.email, form.password);

      if (!isLoggedIn) {
        error.value = 'Invalid email or password';
        return;
      }

      appController.isAuthenticated.value = true;
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      AppLogging().d('Login error - $e');

      error.value = "Login error - $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
      isLoading.value = true;
      error.value = '';

    try {
      await authRepository.logout();
      await authTokenStorage.clear();

      appController.isAuthenticated.value = false;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      AppLogging().d('Logout error - $e');

      error.value = "Logout failed: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }
}
