import 'package:get/get.dart';
import 'package:learn_getx/config/app_endpoint.dart';
import 'package:learn_getx/config/app_logging.dart';
import 'package:learn_getx/config/models/api_response.dart';
import 'package:learn_getx/features/auth/services/auth_token_storage.dart';
import 'package:learn_getx/features/auth/models/auth_tokens.dart';
import 'package:learn_getx/features/auth/models/login_request.dart';
import 'package:learn_getx/config/api_service.dart';

class AuthRepository {
  final ApiService apiService = Get.find<ApiService>();
  final AppLogging logging = Get.find<AppLogging>();
  final AuthTokenStorage authTokenStorage = Get.find<AuthTokenStorage>();

  Future<bool> login(String email, String password) async {
    logging.d('Starting login');

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await apiService.post(
        AppEndpoint.login,
        data: request.toJson(),
      );

      if (response.data == null) {
        throw Exception('No response data received from server');
      }

      final loginResponse = ApiResponse.fromJson(response.data);
      if (loginResponse.success) {
        await _handleLoginSuccess(response);

        return true;
      } else {
        logging.e('Cannot login, got success is false');
        return false;
      }
    } catch (e) {
      logging.e('Error during login - $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    logging.d('Starting logout');

    try {
      final response = await apiService.delete(AppEndpoint.logout);
      logging.d('Logout response received: ${response.data}');

      await _handleLogoutSuccess();
    } catch (e) {
      logging.e('Error during login - $e');
    }
  }

  _handleLoginSuccess(response) async {
    final tokens = AuthTokens.fromHeaders(response.headers);
    await authTokenStorage.save(tokens);
    await apiService.setAuthHeaders(tokens);
  }

  _handleLogoutSuccess() async {
    await authTokenStorage.clear();
    await apiService.clearAuthHeaders();
  }
}
